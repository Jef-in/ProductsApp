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
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
   
    func buildProductView() {
        productView.layer.borderColor = UIColor(red: 0.804, green: 0.804, blue: 0.804, alpha: 1).cgColor
        productView.layer.borderWidth = 1.0
        productView.layer.cornerRadius = 12.0
    }
}
