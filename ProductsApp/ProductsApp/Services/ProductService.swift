//
//  ProductService.swift
//  ProductsApp
//
//  Created by Jefin on 20/05/22.
//

import Combine
import Foundation

enum APIError: LocalizedError {
  case invalidRequestError(String)
  case networkError(Error)
    
}

public protocol ProductServiceable {
    func getProducts() -> AnyPublisher<[Product], Error>
}

class ProductService: ProductServiceable {
    private let baseURL: String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func getProducts() -> AnyPublisher<[Product], Error> {
        let path = "/products"
        let urlString = baseURL + path
        guard let url = URL(string: urlString) else {
            return Fail(error: APIError.invalidRequestError("Invalid URL"))
                .eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { error in APIError.networkError(error) }
            .map(\.data)
            .decode(type: [Product].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
