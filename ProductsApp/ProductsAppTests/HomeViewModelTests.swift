//
//  HomeViewModelTests.swift
//  ProductsAppTests
//
//  Created by Jefin on 21/05/22.
//

import XCTest
@testable import ProductsApp

class HomeViewModelTests: XCTestCase {
    var subject: HomeViewable!
    var mockProductService: MockProductService!
    
    override func setUp() {
        super.setUp()
        mockProductService = MockProductService()
        subject = HomeViewModel(productService: mockProductService)
    }
    
    override func tearDown() {
        mockProductService = nil
        subject = nil
        super.tearDown()
    }
    
    func testWhenViewModelIsAccessedAndGetProductsServiceIsCalledShouldCallGetProducts() {
        _ = subject.getProducts()
        XCTAssertTrue(mockProductService.getProductsCalled)
    }
}
