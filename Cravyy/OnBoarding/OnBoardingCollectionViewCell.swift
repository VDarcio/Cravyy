//
//  OnBoardingCollectionViewCell.swift
//  Cravyy
//
//  Created by VD on 12/09/2021.
//

import UIKit

class OnBoardingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var slideImage: UIImageView!
    @IBOutlet weak var slideTitle: UILabel!
    @IBOutlet weak var slideDescription: UILabel!
    
  
    
    //Func called from OnBoardingViewController to Populate Cell
    func setup(_ slide: OnBoardingSlide){
        slideImage.image =  slide.image
        slideTitle.text = slide.title
        slideDescription.text = slide.description 
    }
    
    
}
