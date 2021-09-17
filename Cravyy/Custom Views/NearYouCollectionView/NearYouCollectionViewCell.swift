//
//  NearYouCollectionViewCell.swift
//  Cravyy
//
//  Created by VD on 17/09/2021.
//

import UIKit

class NearYouCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var restarauntsImageView: UIImageView!
    @IBOutlet weak var restarauntsName: UILabel!
    @IBOutlet weak var restarauntsDistance: UILabel!
    
    
    
    func setup(_ restautant:Restaurants){
        restarauntsName.text = restautant.name
        restarauntsDistance.text = restautant.description
        restarauntsImageView.image = restautant.image
        
    }
    
    

}
