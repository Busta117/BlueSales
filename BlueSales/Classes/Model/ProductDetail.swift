//
//  ProductDetail.swift
//  BlueSales
//
//  Created by Santiago Bustamante on 6/9/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class ProductSpecificationSummary: Mappable {
    var name = ""
    var stringValue: String?
    var boolValue = false
    
    var isBool: Bool {
        return (stringValue == nil)
    }
    
    required init?(map: Map){ }
    
    func mapping(map: Map) {
        name            <- map["name"]
        stringValue     <- map["stringValue"]
        boolValue       <- map["boolValue"]
    }
}

class ProductReviewInformation: Mappable {
    
    var reviewAverage = 0.0
    var reviewCount = 0
    var reviews = [ProductReview]()
    
    required init?(map: Map){ }
    
    func mapping(map: Map) {
        reviewAverage    <- map["reviewSummary.reviewAverage"]
        reviewCount     <- map["reviewSummary.reviewCount"]
        reviews         <- map["reviews"]
    }
}

class ProductReview: Mappable {
    
    var id: Int64 = 0
    var pros = [String]()
    var cons = [String]()
    var creationDate = Date(timeIntervalSince1970: 0)
    var creatorName = ""
    var review = ""
    var title = ""
    var rating = 0.0
    var languageCode = ""
    
    required convenience init?(map: Map) {self.init()}
    
    func mapping(map: Map) {
        id              <- map["reviewId"]
        pros            <- map["pros"]
        cons            <- map["cons"]
        creationDate    <- (map["creationDate"], ISO8601DateTransform())
        creatorName     <- map["creatorName"]
        review          <- map["description"]
        title           <- map["title"]
        rating          <- map["rating"]
        languageCode    <- map["languageCode"]
    }
}

class ProductDetail: Mappable {
    
    var id: Int64 = 0
    var productName = ""
    var productText = ""
    var USPs = [String]()
    var pros = [String]()
    var cons = [String]()
    var availabilityState = 0
    var salesPriceIncVat = 0.0
    var salesPriceExVat = 0.0
    var productUriImages = [String]()
    var deliveredWith = [String]()
    var specificationSummary = [ProductSpecificationSummary]()
    var nextDayDelivery = false
    var recommendedAccessories = [Int64]()
    
    required init?(map: Map){ }
    
    func mapping(map: Map) {
        id                      <- map["productId"]
        productName             <- map["productName"]
        productText             <- map["productText"]
        USPs                    <- map["USPs"]
        pros                    <- map["pros"]
        cons                    <- map["cons"]
        availabilityState       <- map["availabilityState"]
        salesPriceIncVat        <- map["salesPriceIncVat"]
        salesPriceExVat         <- map["salesPriceExVat"]
        productUriImages        <- map["productImages"]
        deliveredWith           <- map["deliveredWith"]
        specificationSummary    <- map["specificationSummary"]
        nextDayDelivery         <- map["nextDayDelivery"]
        recommendedAccessories  <- map["recommendedAccessories"]
    }
    
    class func forProduct(_ product: Product, complete: @escaping (ProductDetail?, Error?)->()) {
        
        let url = "https://bdk0sta2n0.execute-api.eu-west-1.amazonaws.com/ios-assignment/product/\(product.id)"
        
        Alamofire.request(url)
            .validate()
            .responseObject{ (response: DataResponse<ProductDetail>) in
            if let detail = response.value {
                complete(detail, nil)
            } else {
                complete(nil, response.error)
            }
        }
    }
    
}
