//
//  UiViewhelper.swift
//  Cravyy
//
//  Created by VD on 13/09/2021.
//

import Foundation
import UIKit

extension UIView{
    //computed property to set corner radius on main.storyboard
    @IBInspectable var cornerradius :CGFloat{
        get {return self.cornerradius}
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
