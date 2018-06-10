//
//  Product.swift
//  BlueSales
//
//  Created by Santiago Bustamante on 6/9/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class ProductPromoIcon: Mappable {
    var text = ""
    var type = ""
    
    required init?(map: Map){ }
    
    func mapping(map: Map) {
        text <- map["text"]
        type <- map["type"]
    }
}

class Product: Mappable, PageMapContext {
    
    var id: Int64 = 0
    var name = ""
    var USPs = [String]()
    var availabilityState = 0
    var salesPriceIncVat = 0.0
    var imageUri = ""
    var coolbluesChoiceInformationTitle = ""
    var promoIcon: ProductPromoIcon?
    var nextDayDelivery = false
    
    var reviewAverage = 0.0
    var reviewCount = 0
    
    func mappingResultsKeypath() -> String {
        return "products"
    }
    
    required convenience init?(map: Map) {self.init()}
    
    func mapping(map: Map) {
        id                                  <- map["productId"]
        name                                <- map["productName"]
        USPs                                <- map["USPs"]
        availabilityState                   <- map["availabilityState"]
        salesPriceIncVat                    <- map["salesPriceIncVat"]
        imageUri                            <- map["productImage"]
        coolbluesChoiceInformationTitle     <- map["coolbluesChoiceInformationTitle"]
        promoIcon                           <- map["promoIcon"]
        nextDayDelivery                     <- map["nextDayDelivery"]
        
        reviewAverage                       <- map["reviewInformation.reviewSummary.reviewAverage"]
        reviewCount                         <- map["reviewInformation.reviewSummary.reviewCount"]
        
    }

    
    class func search(query: String, currentPage: Int = 0, complete: @escaping (Page<Product>?, Error?)->() ) {
        
        let url = "https://bdk0sta2n0.execute-api.eu-west-1.amazonaws.com/ios-assignment/search"
        let params: [String: Any] = ["query": query, "page": currentPage + 1]
        
        Alamofire.request(url, parameters: params)
            .validate()
            .responseObject(context: Product()) { (response: DataResponse<Page<Product>>) in
            if let page = response.value {
                complete(page, nil)
            } else {
                complete(nil, response.error)
            }
        }
        
    }
    
    
    func detail(complete: @escaping (ProductDetail?, Error?)->()) {
        ProductDetail.forProduct(self, complete: complete)
    }
    
    
}
