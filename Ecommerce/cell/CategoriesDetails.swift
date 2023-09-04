//
//  CategoriesDetails.swift
//  Ecommerce
//
//  Created by Andrew Ihab on 05/04/2023.
//

import UIKit
import Alamofire
import Kingfisher

class CategoriesDetails: UICollectionViewCell {
    static let ID = String(describing: CategoriesDetails.self)
    
    @IBOutlet weak var categoryDetailsPrice: UILabel!
    @IBOutlet weak var categoryDetailsImg: UIImageView!
    
    @IBOutlet weak var categoryDetailsName: UILabel!
    func configure(products:Datum) {
        
        categoryDetailsName.text = products.name
        categoryDetailsPrice.text = "$\(products.price)"
        categoryDetailsImg.kf.setImage(with: URL(string: products.image!))
        
    }
}
