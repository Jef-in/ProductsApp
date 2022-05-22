//
//  MockProductDetailViewModel.swift
//  ProductsApp
//
//  Created by Jefin on 22/05/22.
//

import Foundation

class MockProductDetailViewModel: ProductDetailViewable {
    var name = "test product"
    var price = 10.0
    var description = "test description"
    var category = "test category"
    var image = "https://picsum.photos/200"
    var ratingValue = 0.0
    var ratingCountValue = 10
    
    var productName: String {
        name
    }
    
    var categoryName: String {
        category
    }
    
    var rating: Double {
        ratingValue
    }
    
    var ratingCount: Int {
        ratingCountValue
    }
    
    var productDescription: String {
        description
    }
    
    var productPrice: Double {
        price
    }
    
    var productImage: String {
        image
    }
}
