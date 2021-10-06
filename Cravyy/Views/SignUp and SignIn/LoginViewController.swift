//
//  LoginViewController.swift
//  Cravyy
//
//  Created by VD on 15/09/2021.
//

import UIKit
import Firebase
import ProgressHUD
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        
        
        //check if the user has typed on all fields
        if let email = emailTextField.text, let password = passwordTextField.text{
            //call firebase to check if user exists
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                // check for errors
                if let e = error {
                    ProgressHUD.showError(e.localizedDescription)
                    return
                }else{
                    // get reference to the user that just logged in
                    guard let user = Auth.auth().currentUser else {
                        fatalError()
                        return}
                    //retrieve its username and userId from firestoreDataBase
                    UserService.retrieveProfile(userID: user.uid) { loggedUser in
                        
                        if loggedUser == nil {
                            print("create profile")
                            
                        }
                        else{
                            //save the existing profile to our localstorage
                            LocalStorageService.saveUser(userID: loggedUser?.userId, username: loggedUser?.username)
                            
                            //present HomeVC
                            let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "tabBarVC")
                            self.view.window?.rootViewController = tabBarVC
                            self.view.window?.makeKeyAndVisible()
                        }
                    }
                   
                    
                }
            
                
                
            }
            
            
            
            
            
            
        }
        
         
        
        
    }
    


}
