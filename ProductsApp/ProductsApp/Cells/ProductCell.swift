//
//  ProductCell.swift
//  ProductsApp
//
//  Created by Jefin on 19/05/22.
//

import Cosmos
import UIKit

class ProductCell: UITableViewCell {
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
   
    func buildProductView() {
        productView.layer.borderColor = UIColor(red: 0.804, green: 0.804, blue: 0.804, alpha: 1).cgColor
        productView.layer.borderWidth = 1.0
        productView.layer.cornerRadius = 12.0
    }
    
    func configureProductCell(product: Product) {
        productImage.loadImage(imageUrl: product.image ?? "")
        productTitleLabel.text = product.title
        priceLabel.text = "$ \(String(product.price ?? 0.0))"
        guard let rating = product.rating else { return }
        ratingView.rating = rating.rate ?? 0.0
        ratingLabel.text = "\(String(rating.rate ?? 0.0)) (\(String(rating.count ?? 0)))"
    }
}
