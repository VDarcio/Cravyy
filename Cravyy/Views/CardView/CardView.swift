//
//  CardView.swift
//  Cravyy
//
//  Created by VD on 17/09/2021.
//

import Foundation
import UIKit

class CardView: UIView {
    
    //set the shaddows to gree if user is in dark mode and black if user is in light mode
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        switch traitCollection.userInterfaceStyle {
                case .light:
            initialsetup()
                case .dark, .unspecified:
                    initialsetup2()
        @unknown default:
            initialsetup()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        switch traitCollection.userInterfaceStyle {
                case .light:
            initialsetup()
                case .dark, .unspecified:
                    initialsetup2()
        @unknown default:
            initialsetup()
        }
    }
    //light mode
    private func initialsetup(){
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.2
        cornerradius = 10
        
    }
    // dark mode
    private func initialsetup2(){
        layer.shadowColor = UIColor.systemGreen.cgColor
        layer.shadowOffset = .zero
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.3
        cornerradius = 10
        
    }
    
    
    
    }
   

