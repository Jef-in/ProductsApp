//
//  MockProductService.swift
//  ProductsApp
//
//  Created by Jefin on 21/05/22.
//

import Combine
import Foundation
import UIKit

class MockProductService: ProductServiceable {
    
    var getProductsCalled = false
    let error = NSError(domain: "test", code: 0, userInfo: nil)
    let fakeRating = Rating(rate: 0.0, count: 0)
    lazy var fakeResponse = Product(id: 1, title: "test product", price: 10.0, description: "test description", category: "test category", image: "test image", rating: fakeRating)
    
    func getProducts() -> AnyPublisher<[Product], Error> {
        getProductsCalled = true
        
        return Just([fakeResponse])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
