//
//  BannerCVCollectionViewCell.swift
//  Ecommerce
//
//  Created by Andrew Ihab on 05/04/2023.
//

import UIKit
import Kingfisher
class BannerCVCollectionViewCell: UICollectionViewCell {
    
    static let ID = String(describing: BannerCVCollectionViewCell.self)

    @IBOutlet weak var bannerImg: UIImageView!
    
    func setup(with banner:Bannersdata){
        bannerImg.kf.setImage(with: URL(string: banner.image!))
    }

}
