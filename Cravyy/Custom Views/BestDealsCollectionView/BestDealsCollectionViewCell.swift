//
//  BestDealsCollectionViewCell.swift
//  Cravyy
//
//  Created by VD on 17/09/2021.
//

import UIKit

class BestDealsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var restaurantsName: UILabel!
    @IBOutlet weak var restaurantsPrice: UILabel!
    @IBOutlet weak var restaurantsImage: UIImageView!
    
    func setup(_ restaurant: Restaurants){
        restaurantsName.text=restaurant.name
        restaurantsPrice.text=restaurant.description
        restaurantsImage.image=restaurant.image
        
    }
    
}
