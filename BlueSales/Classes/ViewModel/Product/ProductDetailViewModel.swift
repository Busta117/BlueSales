//
//  ProductDetailViewModel.swift
//  BlueSales
//
//  Created by Santiago Bustamante on 6/10/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import UIKit
import RxSwift

struct ProductDetailViewModel {

    var product: Product
    let detail = Variable<ProductDetail?>(nil)
    let error = Variable<Error?>(nil)
    
    func load() {
        product.detail { (detail, error) in
            self.detail.value = detail
            self.error.value = error
        }
    }
    
}
