//
//  CardView.swift
//  Cravyy
//
//  Created by VD on 17/09/2021.
//

import Foundation
import UIKit

class CardView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialsetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialsetup()
    }
    
    private func initialsetup(){
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.1
        cornerradius = 10
        
    }
}