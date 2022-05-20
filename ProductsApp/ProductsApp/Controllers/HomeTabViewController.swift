//
//  HomeTabViewController.swift
//  ProductsApp
//
//  Created by Jefin on 19/05/22.
//

import UIKit

class HomeTabViewController: UIViewController {
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var productTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildView()
    }
    
    private func buildView() {
        configureSearchView()
    }
    
    private func configureSearchView() {
        searchView.layer.borderColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1).cgColor
        searchView.layer.borderWidth = 1.0
        searchView.layer.cornerRadius = 10.0
    }
}

extension HomeTabViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        cell.buildProductView()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "ProductDetails") as! ProductDetailsViewController
        navigationController?.pushViewController(controller, animated: true)
    }
}
