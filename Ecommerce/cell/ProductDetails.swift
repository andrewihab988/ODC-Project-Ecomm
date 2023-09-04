//
//  ProductDetails.swift
//  Ecommerce
//
//  Created by Andrew Ihab on 11/04/2023.
//
import UIKit

class ProductDetails: UICollectionViewCell {
    
    static let ID = String(describing: ProductDetails.self)
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    func setup(with product: Data2) {
        productNameLabel.text = product.name
        productPriceLabel.text = "$\(product.id)"
        
    
        
    }
    
}
    



