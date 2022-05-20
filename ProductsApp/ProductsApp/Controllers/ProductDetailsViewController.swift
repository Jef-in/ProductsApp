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
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var ratingValueLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var favouritesImage: UIImageView!
    @IBOutlet weak var favouritesView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    private func buildView() {
        bottomView.layer.cornerRadius = 45.0
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bottomView.layer.masksToBounds = true
        addToCartButton.layer.cornerRadius = 10.0
        addToCartButton.layer.masksToBounds = true
        favouritesView.layer.cornerRadius = (favouritesView.frame.size.height/2)
        favouritesView.layer.masksToBounds = true
    }
   
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favouritesButtonPressed(_ sender: Any) {

    }
}
