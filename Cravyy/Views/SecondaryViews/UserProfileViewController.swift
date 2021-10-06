//
//  UserProfileViewController.swift
//  Cravyy
//
//  Created by VD on 22/09/2021.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class UserProfileViewController: UIViewController {

    let def = UserDefaults.standard
    @IBOutlet weak var signOutLabel: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = "Hello \(def.value(forKey: K.LocalSTorage.usernameKey) as? String ?? "")"
    checkuser()
    }
    
    func checkuser()->Bool{
        //check if there is a user signed in
        if Auth.auth().currentUser == nil{
            //change button text and color
            signOutLabel.setTitle("Create account", for: .normal)
            return true
        }else{
            return false
        }
        
    }
    
    @IBAction func signOutPressed(_ sender: Any) {
        
        //if there is no user signed in, it will take them to the create account menu   
        if checkuser(){
            let initialVC = self.storyboard?.instantiateViewController(withIdentifier: "FirstVC")
            self.view.window?.rootViewController = initialVC
            self.view.window?.makeKeyAndVisible()
            
        }
        
        let alert = UIAlertController(title: "Are you sure you want to Sign out?", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Sign Out", style: .destructive) { action in
            
            do{
                try? Auth.auth().signOut()
                LocalStorageService.clearUser()
            }catch{
                print(error)
            }
            let initialVC = self.storyboard?.instantiateViewController(withIdentifier: "FirstVC")
            self.view.window?.rootViewController = initialVC
            self.view.window?.makeKeyAndVisible()
            
        }
        let actionTwo = UIAlertAction(title: "Cancel", style: .default) { actionTwo in
            
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(action)
        alert.addAction(actionTwo)
        present(alert, animated: true, completion: nil)
        
        
        

    }
    
    
}
