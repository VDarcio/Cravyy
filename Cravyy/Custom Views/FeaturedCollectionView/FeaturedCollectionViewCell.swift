//
//  FeaturedCollectionViewCell.swift
//  Cravyy
//
//  Created by VD on 17/09/2021.
//

import UIKit

class FeaturedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restautantName: UILabel!
    @IBOutlet weak var restaurantDetail: UILabel!
    
    func setup(_ featured:Featured){
        restautantName.text = featured.name
        restaurantDetail.text = featured.rating
        restaurantImageView.image = featured.image
        
    }
    
}
