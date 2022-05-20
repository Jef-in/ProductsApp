//
//  ProductModel.swift
//  ProductsApp
//
//  Created by Jefin on 20/05/22.
//

public struct Product: Decodable {
    let id: Int?
    let title: String?
    let price: Double?
    let description: String?
    let category: String?
    let image: String?
    let rating: Rating?
}

public struct Rating: Decodable {
    let rate: Double?
    let count: Int?
}
