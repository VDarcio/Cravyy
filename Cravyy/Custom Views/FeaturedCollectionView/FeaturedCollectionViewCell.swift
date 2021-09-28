//
//  FeaturedCollectionViewCell.swift
//  Cravyy
//
//  Created by VD on 17/09/2021.
//

import UIKit
import Kingfisher

class FeaturedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restautantName: UILabel!
    @IBOutlet weak var restaurantDetail: UILabel!
    
    func setup(_ featured:restaurantsModel){
        if featured.photo?.images?.original != nil{
            restaurantImageView.kf.setImage(with: featured.photo?.images?.original?.url?.asURL)
        }else{
            restaurantImageView.image = UIImage(named: "brazillian")
        }
        restautantName.text = featured.name
        restaurantDetail.text = "⭐️ \(featured.rating ?? "")/5"
        
    }
    
}
