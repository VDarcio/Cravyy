//
//  FirstViewController.swift
//  Cravyy
//
//  Created by VD on 13/09/2021.
//

import UIKit

class FirstViewController: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var WelcomeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
   private var signUpVC :SignUpViewController?
   private var loginVC: LoginViewController?
    
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         //instantiateViews
        signUpVC = storyboard?.instantiateViewController(identifier: "SignUpVC") as? SignUpViewController
        loginVC = storyboard?.instantiateViewController(identifier: "LoginVC") as? LoginViewController
        
      
        
    }
    

    
    @IBAction func SignupWithGoogleTapped(_ sender: Any) {
    }
    
    @IBAction func signUptapped(_ sender: Any) {
        //check if signupVc exists, if it does... present modally
        if signUpVC != nil{
            present(signUpVC!, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        //check if loginVC exists, if it does... present modally
        if loginVC != nil{
            present(loginVC!, animated: true, completion: nil)
        }
        
    }
    
   
  
}


