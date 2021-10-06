//
//  UserService.swift
//  Cravyy
//
//  Created by VD on 04/10/2021.
//

import Foundation
import FirebaseFirestore

class UserService{
    
    static func createUser(userID:String, username: String, completion: @escaping(AppUser?)->Void){
        
        let profiledata = ["username": username]
        
        let db = Firestore.firestore()
        
        db.collection("users").document(userID).setData(profiledata) { error in
            if error == nil{
                
                var u = AppUser()
                u.username = username
                u.userId = userID
                
                completion (u)
            }
            else{
                completion(nil)
            }
        }
        
    }
    
    
    
}
