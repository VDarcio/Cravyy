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
    
    
    
    func setup(_ nearYou:Nearyou){
        restarauntsName.text = nearYou.name
        restarauntsDistance.text = nearYou.distance
        restarauntsImageView.image = nearYou.image
        
    }
    
    

}
