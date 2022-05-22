//
//  ProductDetailViewModelTests.swift
//  ProductsAppTests
//
//  Created by Jefin on 22/05/22.
//

import XCTest
@testable import ProductsApp

class ProductDetailViewModelTests: XCTestCase {
    var subject: ProductDetailViewable!
    let fakeRating = Rating(rate: 0.0, count: 0)
    lazy var fakeProduct = Product(id: 1, title: "test product", price: 10.0, description: "test description", category: "test category", image: "test image", rating: fakeRating)
    
    override func setUp() {
        super.setUp()
        subject = ProductDetailViewModel(product: fakeProduct)
    }
    
    override func tearDown() {
        subject = nil
        super.tearDown()
    }
    func testWhenViewIsLoadedAndProductNameIsAccessedShouldReturnProductTitle() {
        XCTAssertEqual(subject.productName, fakeProduct.title)
    }
    
    func testWhenViewIsLoadedAndProductPriceIsAccessedShouldReturnProductPrice() {
        XCTAssertEqual(subject.productPrice, fakeProduct.price)
    }
    
    func testWhenViewIsLoadedAndProductDescriptionIsAccessedShouldReturnProductDescription() {
        XCTAssertEqual(subject.productDescription, fakeProduct.description)
    }

    func testWhenViewIsLoadedAndProductCategoryIsAccessedShouldReturnProductCategory() {
        XCTAssertEqual(subject.categoryName, fakeProduct.category)
    }
    
    func testWhenViewIsLoadedAndProductImageIsAccessedShouldReturnProductImage() {
        XCTAssertEqual(subject.productImage, fakeProduct.image)
    }
    
    func testWhenViewIsLoadedAndProductRatingIsAccessedShouldReturnProductRating() {
        XCTAssertEqual(subject.rating, fakeProduct.rating?.rate)
    }
    
    func testWhenViewIsLoadedAndProductRatingCountIsAccessedShouldReturnProductRatingCount() {
        XCTAssertEqual(subject.ratingCount, fakeProduct.rating?.count)
    }
}
