//
//  UserDefaults+Extension.swift
//  Cravyy
//
//  Created by VD on 07/10/2021.
//

import Foundation


extension UserDefaults{
    
    private enum UserDefaultsKeys : String{
        
        case hasOnBoarded
        
        case hasSkippedLogin
    }
    var hasOnBoarded : Bool{
        get{
            bool(forKey: UserDefaultsKeys.hasOnBoarded.rawValue)
        }
        set{
            setValue(newValue, forKey: UserDefaultsKeys.hasOnBoarded.rawValue)
        }
    }
    
    var hasSkippedLogin : Bool{
        get{
            bool(forKey: UserDefaultsKeys.hasSkippedLogin.rawValue)
        }
        set{
            setValue(newValue, forKey: UserDefaultsKeys.hasSkippedLogin.rawValue)
        }
    }
}
