//
//  HomeViewModel.swift
//  ProductsApp
//
//  Created by Jefin on 20/05/22.
//

import Combine

protocol HomeViewable {
    func getProducts() -> AnyPublisher<[Product], Error>
}

class HomeViewModel: HomeViewable {
    
    private let productService: ProductServiceable
    
    init(productService: ProductServiceable) {
        self.productService = productService
    }
    
    func getProducts() -> AnyPublisher<[Product], Error> {
        productService.getProducts()
            .map{ $0 }
            .eraseToAnyPublisher()
    }
}
