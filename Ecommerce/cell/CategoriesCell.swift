//
//  CategoriesCell.swift
//  Ecommerce
//
//  Created by Andrew Ihab on 05/04/2023.
//

import UIKit
import Kingfisher
class CategoriesCell: UICollectionViewCell {
    static let ID = String(describing: CategoriesCell.self)
    @IBOutlet weak var categoryImg: UIImageView!
    
    @IBOutlet weak var categoryName: UILabel!
    
    func setup2(with category:Data2){
        categoryName.text = category.name
        categoryImg.kf.setImage(with: URL(string: category.image))
    }

}
