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
    
    func setup(_ restautant:Restaurants){
        restautantName.text = restautant.name
        restaurantDetail.text = restautant.description
        restaurantImageView.image = restautant.image
        
    }
    
}
