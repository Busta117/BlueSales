//
//  SearchProductTableViewCell.swift
//  BlueSales
//
//  Created by Santiago Bustamante on 6/10/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import UIKit
import AlamofireImage

class SearchProductTableViewCell: UITableViewCell {

    @IBOutlet weak var choiceInformationTitleLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nextDayDeliveryLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        productImageView.af_cancelImageRequest()
        productImageView.image = nil
    }
    
    func setup(with product: Product) {
        
        choiceInformationTitleLabel.text = product.coolbluesChoiceInformationTitle
        productImageView.setImage(withUri: product.imageUri)
        titleLabel.text = product.name
        infoLabel.text = Array(product.USPs[..<3]).map({"・\($0)"}).joined(separator: "\n")

        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "nl_NL")
        formatter.numberStyle = .currency
        priceLabel.text = formatter.string(from: NSNumber(floatLiteral: product.salesPriceIncVat))
        
        nextDayDeliveryLabel.text = product.nextDayDelivery ? "Next day delivery" : ""
        
        formatter.numberStyle = .decimal
        ratingLabel.text = "Rating \(formatter.string(from: NSNumber(floatLiteral: product.reviewAverage))!)/10 | \(product.reviewCount) reviews"
        
    }
    
}
