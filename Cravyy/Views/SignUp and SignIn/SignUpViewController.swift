//
//  SignUpViewController.swift
//  Cravyy
//
//  Created by VD on 14/09/2021.
//

import UIKit
import Firebase
import FirebaseFirestore
import ProgressHUD

class SignUpViewController: UIViewController {
 
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func signUpTapped(_ sender: Any) {
       //check if user has typed on all 3 fields
        if let email = emailTextField.text, let password = passwordTextField.text{
            //call firebase to create account on the server
            Auth.auth().createUser(withEmail: email, password: password) { data, error in
                //check if there is an error
                if let e = error{
                    print(e.localizedDescription)
                    ProgressHUD.showError(e.localizedDescription)
                }else{
                    //trim the whitespaces on the username, if there is any
                    let username = self.nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    //call the method on userService that saves the user's ID and UserName on our FireStore DataBase
                                UserService.createUser(userID: Auth.auth().currentUser!.uid, username: username) { user in
                                    if user != nil{
                                        
                                        //save user to userdeafults for AutoLogin next time
                                        LocalStorageService.saveUser(userID: user?.userId, username: user?.username)
                                        
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
