//
//  Page.swift
//  BlueSales
//
//  Created by Santiago Bustamante on 6/9/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

protocol PageMapContext: MapContext {
    func mappingResultsKeypath() -> String
}

class Page<T: Mappable>: Mappable {
    
    var currentPage = 0
    var pageSize = 0
    var totalResults = 0
    var pageCount = 0
    var results = [T]()
    
    required init?(map: Map){ }
    
    func mapping(map: Map) {
        currentPage <- map["currentPage"]
        pageSize <- map["pageSize"]
        totalResults <- map["totalResults"]
        pageCount <- map["pageCount"]
        
        if let context = map.context as? PageMapContext {
            results <- map[context.mappingResultsKeypath()]
        } else {
            assertionFailure("Object needs to implement a context of type PageMapContext in order to get the results")
        }
        
    }

}
