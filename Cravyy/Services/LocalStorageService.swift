//
//  LocalStorageService.swift
//  Cravyy
//
//  Created by VD on 06/10/2021.
//

import Foundation

class LocalStorageService{
    
    static func saveUser(userID: String?, username:String?){
        //get reference to userdefaults
        let def = UserDefaults.standard
        //save the userID and username for future use
        def.set(userID, forKey: K.LocalSTorage.userIDKey)
        def.set(username, forKey: K.LocalSTorage.usernameKey)
    }
    
    static func loadUser()->AppUser?{
        let defaults = UserDefaults.standard
      
        // fetch the username and userID from userdefaults
        let userid = defaults.value(forKey: K.LocalSTorage.userIDKey) as? String
        let username = defaults.value(forKey: K.LocalSTorage.usernameKey) as? String
        
        if userid != nil && username != nil{
            return AppUser(userId: userid, username: username)
            
        }
        else{
            return nil
        }
    }
    
    static func clearUser(){
        
        let defaults = UserDefaults.standard
        
        defaults.setValue(nil, forKey: K.LocalSTorage.usernameKey)
        defaults.setValue(nil, forKey: K.LocalSTorage.usernameKey)
    }

    
    
    
}

