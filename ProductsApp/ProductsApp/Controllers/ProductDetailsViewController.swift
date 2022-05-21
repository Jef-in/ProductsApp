//
//  ProductDetailsViewController.swift
//  ProductsApp
//
//  Created by Jefin on 20/05/22.
//

import Cosmos
import UIKit

class ProductDetailsViewController: UIViewController {
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var ratingValueLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var favouritesImage: UIImageView!
    @IBOutlet weak var favouritesView: UIView!
    
    var viewModel: ProductDetailViewable?

    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        loadData()
    }
    
    private func buildView() {
        bottomView.layer.cornerRadius = 45.0
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bottomView.layer.masksToBounds = true
        addToCartButton.layer.cornerRadius = 10.0
        addToCartButton.layer.masksToBounds = true
        favouritesView.layer.cornerRadius = (favouritesView.frame.size.height/2)
        favouritesView.layer.masksToBounds = true
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    private func loadData() {
        guard let viewModel = viewModel else { return }
        categoryNameLabel.text = viewModel.categoryName
        productNameLabel.text = viewModel.productName
        ratingView.rating = viewModel.rating
        ratingValueLabel.text = "\(viewModel.rating) (\(viewModel.ratingCount))"
        descriptionTextView.text = viewModel.productDescription
        descriptionTextView.sizeToFit()
        priceLabel.text = "$ \(viewModel.productPrice)"
        productImageView.loadImage(imageUrl: viewModel.productImage)
    }
   
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favouritesButtonPressed(_ sender: Any) {

    }
}
