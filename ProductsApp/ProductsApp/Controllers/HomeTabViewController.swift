//
//  HomeTabViewController.swift
//  ProductsApp
//
//  Created by Jefin on 19/05/22.
//

import Combine
import UIKit

class HomeTabViewController: UIViewController {
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var productTable: UITableView!

    private let viewModel: HomeViewable
    var products = [Product]()
    var cancellables = Set<AnyCancellable>()
    
    init(viewModel: HomeViewable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        let productService = ProductService(baseURL: ProductsConstants.baseURL)
        self.viewModel = HomeViewModel(productService: productService)
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildView()
        getProducts()
    }
    
    private func buildView() {
        configureSearchView()
    }
    
    private func configureSearchView() {
        searchView.layer.borderColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1).cgColor
        searchView.layer.borderWidth = 1.0
        searchView.layer.cornerRadius = 10.0
    }
    
    private func reloadProductTable() {
        DispatchQueue.main.async {
            self.productTable.reloadData()
        }
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
}

extension HomeTabViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        cell.buildProductView()
        cell.productImage.image = nil
        cell.configureProductCell(product: products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewModel = ProductDetailViewModel(product: products[indexPath.row])
        let controller = storyBoard.instantiateViewController(withIdentifier: "ProductDetails") as! ProductDetailsViewController
        controller.viewModel = viewModel
        navigationController?.pushViewController(controller, animated: true)
    }
}
