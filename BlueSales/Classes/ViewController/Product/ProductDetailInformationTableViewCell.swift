//
//  ProductDetailInformationTableViewCell.swift
//  BlueSales
//
//  Created by Santiago Bustamante on 6/11/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import UIKit
import SwiftyMarkdown

class ProductDetailInformationTableViewCell: UITableViewCell {
    
    enum Section {
        case specifications, prosCons, description, includes
    }
    

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    func setup(with detail: ProductDetail, forSection section: ProductDetailInformationTableViewCell.Section) {
        
        switch section {
        case .specifications:
            
            titleLabel.text = "Specifications"
            
            let textArr = detail.specificationSummary.map { value -> String in
                var text = "# \(value.name)\n"
                if value.isBool {
                    text = text + (value.boolValue ? "YES" : "NO")
                } else {
                    text = text + (value.stringValue ?? "")
                }
                return text
            }
            
            let text = textArr.joined(separator: "\n")
            
            let attText = SwiftyMarkdown(string: text)
            attText.h1.color = .coolOrange
            attText.h1.fontName = UIFont.boldSystemFont(ofSize: 15).fontName
            attText.h1.fontSize = 11
            attText.body.fontSize = 12
            descriptionLabel.attributedText = attText.attributedString()
            
            
        case .prosCons:
            titleLabel.text = "Pros and Cons"
            
            let pros = detail.pros.map({"✔︎ \($0)"})
            let cons = detail.cons.map({"✖︎ \($0)"})
            
            descriptionLabel.attributedText = NSAttributedString(string: (pros + cons).joined(separator: "\n"))
            
        case .description:
            titleLabel.text = "Description"
            
            //remove html code in the string if any
            let attrString = try? NSAttributedString(data: detail.productText.data(using: .utf8)!, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            
            descriptionLabel.attributedText = NSAttributedString(string: attrString!.string)
        case .includes:
            titleLabel.text = "Delivered with"
            
            let text = detail.deliveredWith.map({"・\($0)"}).joined(separator: "\n")
            descriptionLabel.attributedText = NSAttributedString(string: text)
        }
        
    }

}
