//
//  FetchedRestaurantsTableViewCell.swift
//  Cravyy
//
//  Created by VD on 23/09/2021.
//

import UIKit
import Kingfisher


class FetchedRestaurantsTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellDistance: UILabel!
    
    func setup(_ restaurant: restaurantsModel){
        cellImage.layer.cornerRadius = 20
                cellImage.clipsToBounds = true
               cellLabel.text = restaurant.name
        cellDistance.text = restaurant.distance_string
        if restaurant.photo?.images?.original != nil{
            cellImage.kf.setImage(with: restaurant.photo?.images?.original?.url?.asURL)
        }else{
            cellImage.image = UIImage(named: "brazillian")
        }
        
        
    }
    func setupFavorites(_ favorite: FavRest){
        cellImage.layer.cornerRadius = 20
                cellImage.clipsToBounds = true
               cellLabel.text = favorite.name
        cellDistance.alpha = 0.0
        if favorite.photourl != nil{
            cellImage.kf.setImage(with: favorite.photourl?.asURL)
        }else{
            cellImage.image = UIImage(named: "brazillian")
        }
    }
    
    
}
