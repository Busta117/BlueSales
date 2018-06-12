//
//  UIImageView.swift
//  BlueSales
//
//  Created by Santiago Bustamante on 6/10/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import UIKit
import AlamofireImage

extension UIImageView {

    open func setImage(withUri url: String?, placeholder: UIImage? = nil){
        
        if let url = url {
            if let url = URL(string: url) {
                self.af_setImage(withURL: url, placeholderImage: placeholder)
                                
            } else {
                if let placeholder = placeholder {
                    self.image = placeholder
                }
            }
        } else {
            if let placeholder = placeholder {
                self.image = placeholder
            }
        }
        
    }
    
}
