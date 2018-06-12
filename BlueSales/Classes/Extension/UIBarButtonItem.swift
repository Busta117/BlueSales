//
//  UIBarButtonItem.swift
//  BlueSales
//
//  Created by Santiago Bustamante on 6/10/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import UIKit

public extension UIBarButtonItem {
    
    public class func `init`(withImage image: UIImage?, color:UIColor? = nil, target: Any? = nil, action: Selector? = nil) -> UIBarButtonItem {
        
        let but: UIButton = UIButton(type: UIButtonType.custom) as UIButton
        but.frame = CGRect(x: 0, y: 0, width: 70, height: 30);
        but.backgroundColor = UIColor.clear
        
        if let color = color{
            but.setImage(image?.image(withTintColor: color), for: .normal)
        }
        
        if let action = action {
            but.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        }
        but.sizeToFit()
        
        let barButton = UIBarButtonItem(customView: but)
        return barButton
        
    }
    
    
    public class func `init`(withTitle title: String?, textColor: UIColor? = nil, target: Any? = nil, action: Selector? = nil) -> UIBarButtonItem {
        
        let but: UIButton = UIButton(type: UIButtonType.custom) as UIButton
        but.frame = CGRect(x: 0, y: 0, width: 50, height: 30);
        but.backgroundColor = UIColor.clear
        but.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        if let textColor = textColor {
            but.setTitleColor(textColor, for: .normal)
        }
        but.setTitle(title, for: .normal)
        if let action = action {
            but.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        }
        but.sizeToFit()
        
        let barButton = UIBarButtonItem(customView: but)
        
        return barButton
    }
    
    
}

