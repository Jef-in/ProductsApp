//
//  ProductDetailViewControllerTests.swift
//  ProductsAppTests
//
//  Created by Jefin on 22/05/22.
//

import XCTest
@testable import ProductsApp

class ProductDetailViewControllerTests: XCTestCase {
    var mockProductDetailViewModel: MockProductDetailViewModel!
    var subject: ProductDetailsViewController!
    override func setUp() {
        super.setUp()
        mockProductDetailViewModel = MockProductDetailViewModel()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        subject = storyboard.instantiateViewController(withIdentifier: "ProductDetails") as? ProductDetailsViewController
        subject.viewModel = mockProductDetailViewModel
        subject.loadViewIfNeeded()
    }
    
    override func tearDown() {
        subject = nil
        mockProductDetailViewModel = nil
        super.tearDown()
    }
    
    func testWhenViewIsLoadedShouldGetDataFromViewModelAndLoadValueInCategoryLabel() {
        mockProductDetailViewModel.category = "test Category"
        subject.viewDidLoad()
        XCTAssertEqual(subject.categoryNameLabel.text, mockProductDetailViewModel.categoryName)
    }
    
    func testWhenViewIsLoadedShouldGetDataFromViewModelAndLoadValueInProductNameLabel() {
        mockProductDetailViewModel.name = "product test"
        subject.viewDidLoad()
        XCTAssertEqual(subject.productNameLabel.text, mockProductDetailViewModel.productName)
    }
    
    func testWhenViewIsLoadedShouldGetDataFromViewModelAndLoadValueInProductDescriptionTextView() {
        mockProductDetailViewModel.description = "product test description"
        subject.viewDidLoad()
        XCTAssertEqual(subject.descriptionTextView.text, mockProductDetailViewModel.productDescription)
    }
    
    func testWhenViewIsLoadedShouldGetDataFromViewModelAndLoadValueInRatingView() {
        mockProductDetailViewModel.ratingValue = 2.5
        subject.viewDidLoad()
        XCTAssertEqual(subject.ratingView.rating, mockProductDetailViewModel.rating)
    }
    
    func testWhenViewIsLoadedShouldGetDataFromViewModelAndLoadValueInPriceLabel() {
        mockProductDetailViewModel.price = 12
        subject.viewDidLoad()
        let expectedValue = "$ \(mockProductDetailViewModel.productPrice)"
        XCTAssertEqual(subject.priceLabel.text, expectedValue)
    }
    
    func testWhenViewIsLoadedShouldGetDataFromViewModelAndLoadValueInRatingLabel() {
        mockProductDetailViewModel.ratingValue = 3.0
        mockProductDetailViewModel.ratingCountValue = 25
        subject.viewDidLoad()
        let expectedValue = "\(mockProductDetailViewModel.rating) (\(mockProductDetailViewModel.ratingCount))"
        XCTAssertEqual(subject.ratingValueLabel.text, expectedValue)
    }
}
