//
//  NearYouCollectionViewCell.swift
//  Cravyy
//
//  Created by VD on 17/09/2021.
//

import UIKit
import Kingfisher

class NearYouCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var restarauntsImageView: UIImageView!
    @IBOutlet weak var restarauntsName: UILabel!
    @IBOutlet weak var restarauntsDistance: UILabel!
    
    
    
    func setup(_ nearYou:restaurantsModel){
        
        restarauntsName.text = nearYou.name
        restarauntsDistance.text = "📍\(nearYou.distance_string ?? "")"
        if nearYou.photo?.images?.original?.url != nil{
            restarauntsImageView.kf.setImage(with: nearYou.photo?.images?.original?.url?.asURL)
        }else{
            restarauntsImageView.image = UIImage(named: "brazillian")
        }
        
    }
    
    

}
