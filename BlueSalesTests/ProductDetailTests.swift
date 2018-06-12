//
//  ProductDetailTests.swift
//  BlueSalesTests
//
//  Created by Santiago Bustamante on 6/11/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import XCTest

class ProductDetailTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    func testMapping() {
        if let detail = ProductDetail.mocked() {
            
            XCTAssertEqual(detail.productName, "Fake Apple iPhone X id: 785359") // test mapping a string
            XCTAssertEqual(detail.reviewAverage, 9.2) //test nested mapping and number
            XCTAssertEqual(detail.pros.count, 3) // test array mapping
            
            if let specification = detail.specificationSummary.first {
                XCTAssertEqual(specification.name, "RAM-geheugen")
                XCTAssertEqual(specification.stringValue, "3 GB")
            } else {
                XCTFail("couldn't map the specifications")
            }
            
        } else {
            XCTFail("json couldn't be mapped")
        }
    }
    
    
}
