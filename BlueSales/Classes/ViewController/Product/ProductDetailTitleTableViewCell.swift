//
//  ProductDetailTitleTableViewCell.swift
//  BlueSales
//
//  Created by Santiago Bustamante on 6/11/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import UIKit
import AlamofireImage

class ProductDetailTitleTableViewCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var tomorrowDeliveryLabel: UILabel!
    
    private var productImages = [String]()
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        let cellSize = CGSize(width: width, height: collectionView.height)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    
    func setup(with detail: ProductDetail) {
        productImages = detail.productUriImages
        collectionView.reloadData()
        pageControl.numberOfPages = detail.productUriImages.count
        titleLabel.text = detail.productName
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "nl_NL")
        formatter.numberStyle = .currency
        priceLabel.text = formatter.string(from: NSNumber(floatLiteral: detail.salesPriceIncVat))
        
        tomorrowDeliveryLabel.text = detail.nextDayDelivery ? "Next day delivery" : ""
        
        formatter.numberStyle = .decimal
        ratingLabel.text = "Rating \(formatter.string(from: NSNumber(floatLiteral: detail.reviewAverage))!)/10 | \(detail.reviewCount) reviews"
        
    }

}

extension ProductDetailTitleTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return productImages.count
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailImagesCell", for: indexPath)
        
        cell.subviews.forEach {
            $0.subviews.forEach {
                if let imageView = $0 as? UIImageView {
                    imageView.af_cancelImageRequest()
                    imageView.setImage(withUri: productImages[indexPath.row])
                }
            }
        }
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}
