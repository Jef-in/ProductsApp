//
//  HomeTabViewController.swift
//  ProductsApp
//
//  Created by Jefin on 19/05/22.
//

import Combine
import Network
import UIKit

class HomeTabViewController: UIViewController {
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var productTable: UITableView!
    @IBOutlet weak var connectivityView: UIView!
    @IBOutlet weak var searchTextField: UITextField!

    private let viewModel: HomeViewable
    private let networkManager: NetworkManageable
    var products = [Product]()
    var searchedProducts = [Product]()
    var isSearch: Bool = false
    var cancellables = Set<AnyCancellable>()
    
    init(viewModel: HomeViewable,
         networkManager: NetworkManageable) {
        self.viewModel = viewModel
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        let productService = ProductService(baseURL: ProductsConstants.baseURL)
        self.viewModel = HomeViewModel(productService: productService)
        self.networkManager = NetworkManager.shared
        self.networkManager.startMonitoring()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        checkConnectivity()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        networkManager.stopMonitoring()
    }
    private func buildView() {
        configureSearchView()
    }
    
    private func configureSearchView() {
        searchView.layer.borderColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1).cgColor
        searchView.layer.borderWidth = 1.0
        searchView.layer.cornerRadius = 10.0
        searchTextField.addTarget(self, action: #selector(HomeTabViewController.textFieldDidChange(_:)),
                                  for: .editingChanged)
    }
    
    private func reloadProductTable() {
        DispatchQueue.main.async {
            self.productTable.reloadData()
        }
    }
    
    private func checkConnectivity() {
        showNetworkConnectivityView(networkManager.currentStatus == .satisfied)
        networkManager.addObserver(observer: self)
    }
    
    private func showNetworkConnectivityView(_ isConnected: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
            if isConnected {
                DispatchQueue.main.async {
                    self.connectivityView.alpha = 0.0
                    self.getProducts()
                }
            } else {
                DispatchQueue.main.async {
                    self.connectivityView.alpha = 1.0
                }
            }
        }, completion: nil)
    }
    
    func getProducts() {
        viewModel.getProducts()
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .failure(_): break
                case .finished:
                    self.reloadProductTable()
                    break
                }
            }) { [unowned self] products in
                self.products = products
            }.store(in: &cancellables)
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        guard searchTextField.text?.replacingOccurrences(of: " ", with: "") != "" else {
            searchedProducts.removeAll()
            isSearch = false
            return
            
        }
        guard products.count != 0 else { return }
        products.forEach { product in
            guard let searchString = searchTextField.text else { return }
            if (product.title?.lowercased() ?? "").hasPrefix(searchString.lowercased()) {
                self.searchedProducts.append(product)
            }
        }
        isSearch = true
        reloadProductTable()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let searchText = searchTextField.text else { return}
        if searchText.replacingOccurrences(of: " ", with: "").count == 0 {
            isSearch = false
            searchedProducts.removeAll()
            reloadProductTable()
        }
    }
    
}

extension HomeTabViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dataSource = isSearch ? searchedProducts : products
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataSource = isSearch ? searchedProducts : products
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        cell.buildProductView()
        cell.productImage.image = nil
        cell.configureProductCell(product: dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataSource = isSearch ? searchedProducts : products
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewModel = ProductDetailViewModel(product: dataSource[indexPath.row])
        let controller = storyBoard.instantiateViewController(withIdentifier: "ProductDetails") as! ProductDetailsViewController
        controller.viewModel = viewModel
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension HomeTabViewController: NetworkObserveable {
    func statusDidChange(status: NWPath.Status) {
        showNetworkConnectivityView(networkManager.currentStatus == .satisfied)
    }
}
