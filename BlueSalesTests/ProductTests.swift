//
//  ProductTests.swift
//  BlueSalesTests
//
//  Created by Santiago Bustamante on 6/9/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import XCTest

@testable import BlueSales

class ProductTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testProductIsMapeable() {
        
        let product = Product()
        XCTAssertEqual(product.mappingResultsKeypath(), "products")
        
    }
    
    func testSearchProduct() {
        
        if let page = Product.mockedSearch() {
            XCTAssert(page.currentPage > 0)
            if page.totalResults > 0 {
                XCTAssert(page.results.count > 0)
            }
        } else {
            XCTFail("json couldn't be mapped")
        }
        
    }
    
    
    func testProductSuccessfullyMapped() {
        if let page = Product.mockedSearch() {
            if let product = page.results.first {
                
                XCTAssertEqual(product.name, "Apple iPhone 6 32GB Grijs") // checking string mapping
                XCTAssertEqual(product.reviewAverage, 9.1) //checking nested mapping and number
                XCTAssertEqual(product.USPs.count, 3) // checking string's array mapping
                
            } else {
                XCTFail("json is wrong mapped")
            }
            
        } else {
            XCTFail("json couldn't be mapped")
        }
    }
    
    
    func testWrongJsonResponse() {
        
        if let page = Product.mockedFailSearch() {
            if let product = page.results.first {
                
                XCTAssertFalse(product.name == "Apple iPhone 6 32GB Grijs") // checking string mapping
                XCTAssertFalse(product.reviewAverage == 9.1) //checking nested mapping and number
                XCTAssertFalse(product.USPs.count == 3) // checking string's array mapping
                
            } else {
                XCTFail("json is wrong mapped")
            }
            
        } else {
            XCTFail("json couldn't be mapped")
        }
    }
    
    
    
}
