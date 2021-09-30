//
//  ViewAllTableViewCell.swift
//  Cravyy
//
//  Created by VD on 27/09/2021.
//

import UIKit
import Kingfisher

class ViewAllTableViewCell: UITableViewCell {

    @IBOutlet weak var cellimage: UIImageView!
    @IBOutlet weak var cellname: UILabel!
    @IBOutlet weak var celldescription: UILabel!
    
    
    func setup(restaurant: restaurantsModel, tag : Int){
        if restaurant.photo?.images?.original?.url != nil{
            cellimage.kf.setImage(with: restaurant.photo?.images?.original?.url?.asURL)
        }else{
            cellimage.image = UIImage(named: "brazillian")
        }
        
        cellname.text = restaurant.name
       
        switch tag{
        case 0 :
            celldescription.text = "⭐️ \(restaurant.rating ?? "")/5"
            
        case 1 :
            celldescription.text="📍 \(restaurant.distance_string ?? "")"
            
        case 2 :
            if restaurant.price == nil{
                celldescription.alpha = 0.0
            }
            else{
                celldescription.text = "💶 \(restaurant.price ?? "")"
            }
           
            
        default: return
        }
    }
}
