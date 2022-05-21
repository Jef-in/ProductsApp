//
//  ProductDetailViewModel.swift
//  ProductsApp
//
//  Created by Jefin on 21/05/22.
//

import Foundation

public protocol ProductDetailViewable {
    var productName: String { get }
    var categoryName: String { get }
    var rating: Double { get }
    var ratingCount: Int { get }
    var productDescription: String { get }
    var productPrice: Double { get }
    var productImage: String { get }
}

class ProductDetailViewModel: ProductDetailViewable {
    private let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var productName: String {
        product.title ?? ""
    }
    
    var categoryName: String {
        product.category ?? ""
    }
    
    var rating: Double {
        product.rating?.rate ?? 0.0
    }
    
    var ratingCount: Int {
        product.rating?.count ?? 0
    }
    
    var productDescription: String {
        product.description ?? ""
    }
    
    var productPrice: Double {
        product.price ?? 0.0
    }
    
    var productImage: String {
        product.image ?? ""
    }
}
