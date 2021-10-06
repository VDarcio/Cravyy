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
    
    static func retrieveProfile(userID:String, completion : @escaping (AppUser?)-> Void){
        //get reference to database
        let db = Firestore.firestore()
        
        //get the specific document for the current profile
        db.collection("users").document(userID).getDocument { snapchot, error in
        
            if error != nil{
                return
            }
            //check the data for nil
            if let profile = snapchot!.data(){
                var u = AppUser()
                u.userId = snapchot?.documentID
                u.username = profile["username"] as? String
                completion(u)
            }
            else{
                print(error)
                completion(nil)
            }
            
        }
        
    }
    
    
    
}
