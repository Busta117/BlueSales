//
//  Navigation.swift
//  BlueSales
//
//  Created by Santiago Bustamante on 6/10/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import UIKit

struct LaunchScreen {
    static func `init`() -> UIViewController {
        return UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()!
    }
}

extension SearchViewController {
    class func launch(viewModel: SearchViewModel = SearchViewModel()) -> SearchViewController {
        let vc = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        vc.viewModel = viewModel
        return vc
    }
}


extension ProductDetailViewController {
    class func launch(product: Product) -> ProductDetailViewController {
        return ProductDetailViewController.launch(viewModel: ProductDetailViewModel(product: product))
    }
    class func launch(viewModel: ProductDetailViewModel) -> ProductDetailViewController {
        let vc = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
        vc.viewModel = viewModel
        return vc
    }
}


