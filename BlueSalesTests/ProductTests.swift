//
//  ProductTests.swift
//  BlueSalesTests
//
//  Created by Santiago Bustamante on 6/9/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import XCTest
import AlamofireObjectMapper
import ObjectMapper

@testable import BlueSales

extension Product {
    class func mockedSearch() -> Page<Product>? {
        
        let jsonText = """
{
    
    "products": [
        {
            "productId": 785359,
            "productName": "Apple iPhone 6 32GB Grijs",
            "reviewInformation": {
                "reviews": [],
                "reviewSummary": {
                    "reviewAverage": 9.1,
                    "reviewCount": 952
                }
            },
            "USPs": [
                "32 GB opslagcapaciteit",
                "4,7 inch Retina HD scherm",
                "iOS 11"
            ],
            "availabilityState": 2,
            "salesPriceIncVat": 369,
            "productImage": "https://image.coolblue.nl/300x750/products/818870",
            "coolbluesChoiceInformationTitle": "middenklasse iPhone",
            "promoIcon": {
                "text": "middenklasse iPhone",
                "type": "coolblues-choice"
            },
            "nextDayDelivery": true
        }
    ],
    "currentPage": 1,
    "pageSize": 24,
    "totalResults": 70,
    "pageCount": 3

}
"""
        if let data = jsonText.data(using: .utf8) {
            do {
                let JSONObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                let parsedObject = Mapper<Page<Product>>(context: Product(), shouldIncludeNilValues: false).map(JSONObject: JSONObject)
                return parsedObject
            } catch {
                return nil
            }
        }
        return nil
    }
}

class ProductTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
    
    func testProductMapeable() {
        
        let product = Product()
        XCTAssertEqual(product.mappingResultsKeypath(), "products")
    }
    
    
}
