//
//  ProductMock.swift
//  BlueSalesTests
//
//  Created by Santiago Bustamante on 6/11/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import UIKit
import ObjectMapper

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
    
    
    class func mockedFailSearch() -> Page<Product>? {
        
        let jsonText = """
{
    
    "products": [
        {
            "productId": 785359,
            "reviewInformation": {
                "reviews": [],
                "reviewSummary": {
                    "reviewAverage": "fail",
                    "reviewCount": 952
                }
            },
            "USPs": [
                "32 GB opslagcapaciteit",
                "4,7 inch Retina HD scherm"
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
                let JSONObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let parsedObject = Mapper<Page<Product>>(context: Product(), shouldIncludeNilValues: false).map(JSONObject: JSONObject)
                return parsedObject
            } catch {
                return nil
            }
        }
        return nil
    }
}
