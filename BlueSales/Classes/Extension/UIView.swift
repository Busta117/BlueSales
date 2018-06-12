//
//  UIView.swift
//  BlueSales
//
//  Created by Santiago Bustamante on 6/10/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import UIKit

public extension UIView {
    
    public var height : CGFloat {
        get{return self.frame.size.height}
        set{frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: newValue)}
    }
    
    public var width : CGFloat {
        get{return self.frame.size.width}
        set{frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: newValue, height: self.frame.size.height)}
    }
    
    public var x : CGFloat {
        get{return self.frame.origin.x}
        set{frame = CGRect(x: newValue, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)}
    }
    
    public var y : CGFloat {
        get{return self.frame.origin.y}
        set{frame = CGRect(x: self.frame.origin.x, y: newValue, width: self.frame.size.width, height: self.frame.size.height)}
    }
    
    public var yCenter : CGFloat {
        get{return self.y + self.height/2.0}
        set{self.y = yCenter - self.height/2.0}
    }
    
    public var xCenter : CGFloat {
        get{return self.x + self.width/2.0;}
        set{self.x = newValue - self.width/2.0}
    }
    
    public var cornerRadius : CGFloat {
        set {
            layer.masksToBounds = true
            layer.cornerRadius =  newValue
            
        }
        get { return layer.cornerRadius}
    }
    
    public var borderWidth : CGFloat {
        set {layer.borderWidth = borderWidth}
        get { return layer.borderWidth}
    }
    
    public var borderColor : UIColor {
        set { layer.borderColor =  newValue.cgColor }
        get { return UIColor(cgColor: layer.borderColor!)}
    }
    
    public func toImage() -> UIImage {
        UIGraphicsBeginImageContext(self.bounds.size);
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return viewImage!
    }
}
