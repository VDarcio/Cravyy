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
    @IBOutlet weak var usernameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = def.value(forKey: K.LocalSTorage.usernameKey) as? String
    
    }
    
    @IBAction func signOutPressed(_ sender: Any) {
        
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
    
    
}
