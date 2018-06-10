//
//  SearchViewModel.swift
//  BlueSales
//
//  Created by Santiago Bustamante on 6/10/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import UIKit
import RxSwift

class SearchViewModel {

    var currentPage = Variable<Page<Product>?>(nil)
    var products = Variable<[Product]>([])
    var error = Variable<Error?>(nil)
    
    fileprivate var isLoading = false
    
    func search(query: String) {
        
        if let currentPage = currentPage.value, currentPage.currentPage == currentPage.pageCount {
            return
        }
        
        guard !query.isFullyEmpty else {
            return
        }
        
        guard !isLoading else {
            return
        }
        
        isLoading = true
        let currentPageNumber = (currentPage.value != nil) ? currentPage.value!.currentPage : 1
        Product.search(query: query, currentPage: currentPageNumber ) { (page, error) in
            self.isLoading = false
            if let page = page {
                self.currentPage.value = page
                self.products.value.append(contentsOf: page.results)
            } else {
                self.error.value = error
            }
        }
    }
    
    func cleanResults() {
        currentPage.value = nil
        products.value.removeAll()
        error.value = nil
    }
    
}
