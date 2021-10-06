//
//  UserProfileViewController.swift
//  Cravyy
//
//  Created by VD on 22/09/2021.
//

import UIKit
import FirebaseAuth


class UserProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOutPressed(_ sender: Any) {
        
        do{
            try? Auth.auth().signOut()
        }catch{
            print(error)
        }
        let initialVC = self.storyboard?.instantiateViewController(withIdentifier: "FirstVC")
        self.view.window?.rootViewController = initialVC
        self.view.window?.makeKeyAndVisible()
    }
    
    
}
