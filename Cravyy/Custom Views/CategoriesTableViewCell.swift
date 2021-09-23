//
//  CategoriesTableViewCell.swift
//  Cravyy
//
//  Created by VD on 23/09/2021.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

  
    @IBOutlet weak var cellImage: UIImageView!
    
    @IBOutlet weak var cellLabel: UILabel!
    
    func setup(_ category: Category){
        
        cellImage.image = category.image
        cellLabel.text = category.name
    }
}
