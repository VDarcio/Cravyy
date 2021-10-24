//
//  BestDealsCollectionViewCell.swift
//  Cravyy
//
//  Created by VD on 17/09/2021.
//

import UIKit
import Kingfisher

class BestDealsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var restaurantsName: UILabel!
    @IBOutlet weak var restaurantsPrice: UILabel!
    @IBOutlet weak var restaurantsImage: UIImageView!
    
    func setup(_ bestDeal: restaurantsModel){
        restaurantsName.text = bestDeal.name
        if bestDeal.price == nil{
            restaurantsPrice.alpha = 0.0
        }
        else{
            restaurantsPrice.text = "💶\(bestDeal.price ?? "")"
        }
        
        if bestDeal.photo?.images?.original?.url != nil{
            restaurantsImage.kf.setImage(with: bestDeal.photo?.images?.original?.url?.asURL)
            
            
            
        }else{
            restaurantsImage.image = UIImage(named: "brazillian")
        }
    }
    
}
