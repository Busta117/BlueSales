//
//  UIImage.swift
//  BlueSales
//
//  Created by Santiago Bustamante on 6/10/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import UIKit

//MARK: - UIImage
public extension UIImage {
    
    public class func `init`(fromColor color: UIColor, size: CGSize = CGSize(width: 10, height: 10)) -> UIImage{
        let imageView = UIView(frame: CGRect(x:0, y:0, width:size.width, height:size.height))
        imageView.backgroundColor = color
        return imageView.toImage()
    }
    
    
    public func maskImage(mask:UIImage!)->UIImage{
        
        let imageReference = self.cgImage
        let maskReference = mask.cgImage!
        
        let imageMask = CGImage(maskWidth: maskReference.width,
                                height: maskReference.height,
                                bitsPerComponent: maskReference.bitsPerComponent,
                                bitsPerPixel: maskReference.bitsPerPixel,
                                bytesPerRow: maskReference.bytesPerRow,
                                provider: maskReference.dataProvider!, decode: nil, shouldInterpolate: true)
        
        let maskedReference = imageReference!.masking(imageMask!)
        
        let maskedImage = UIImage(cgImage:maskedReference!)
        
        return maskedImage
    }
    
    
    public func image(withTintColor color: UIColor) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)
        let rect: CGRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context.clip(to: rect, mask: self.cgImage!)
        color.setFill()
        context.fill(rect);
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return newImage;
        
    }
    
    
    public class func `init`(named name:String, tintColor: UIColor) -> UIImage{
        let image: UIImage = UIImage(named: name)!
        return image.image(withTintColor: tintColor)
    }
    
    public func imageScaled(to sizeA:CGSize) -> UIImage {
        
        let size = sizeA
        
        let maxLong = max(self.size.width, self.size.height)
        let relation = size.width/maxLong
        let newSize:CGSize = CGSize(width: self.size.width*relation, height: self.size.height*relation)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
        
    }
    
}

