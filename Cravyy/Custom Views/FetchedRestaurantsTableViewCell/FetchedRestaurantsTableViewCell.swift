//
//  FetchedRestaurantsTableViewCell.swift
//  Cravyy
//
//  Created by VD on 23/09/2021.
//

import UIKit

class FetchedRestaurantsTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    func setup(_ restaurant: restaurantsModel){
        
        cellLabel.text = restaurant.name
        cellImage.image = UIImage(named: "brazillian")
    }
    
}
