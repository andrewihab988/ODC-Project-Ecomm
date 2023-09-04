//
//  PageCollectionViewCell.swift
//  Ecommerce
//
//  Created by Andrew Ihab on 04/04/2023.
//

import UIKit

class PageCollectionViewCell: UICollectionViewCell {
    static let ID = String(describing: PageCollectionViewCell.self)
    
    @IBOutlet weak var pageImage: UIImageView!
    
    @IBOutlet weak var pageTitle: UILabel!
    
    @IBOutlet weak var pageDesc: UILabel!
    
    func setup(with pageItem:PageItem){
        self.pageImage.image = UIImage(named: pageItem.pageImg!)
        self.pageTitle.text = pageItem.pageTitle
        self.pageDesc.text = pageItem.pageDesc
        
    }
    
}
