//
//  SearchViewController.swift
//  BlueSales
//
//  Created by Santiago Bustamante on 6/9/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func searchAction(_ sender: Any) {
        Product.search(query: "apple") { (page, error) in
            
        }
    }
    
}
