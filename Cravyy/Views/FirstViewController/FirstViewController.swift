//
//  FirstViewController.swift
//  Cravyy
//
//  Created by VD on 13/09/2021.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var WelcomeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    
    var signUpVC :SignUpViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    loadWelcomeLabel()
         signUpVC = storyboard?.instantiateViewController(identifier: "SignUpVC") as? SignUpViewController
        
    
    }
    
    @IBAction func SignupWithGoogleTapped(_ sender: Any) {
    }
    
    @IBAction func signUptapped(_ sender: Any) {
        if signUpVC != nil{
            present(signUpVC!, animated: true, completion: nil)
        }
        
    }
    
    
    
    //MARK:-Methods to Load Labels
    
    func loadWelcomeLabel (){
       
        WelcomeLabel.text=""
              let titleText="Welcome🐒"
                var charIndex = 0.0
              for letter in titleText{
                   Timer.scheduledTimer(withTimeInterval: 0.1*charIndex, repeats: false) { (timer) in
                      self.WelcomeLabel.text?.append(letter)
                   }
                 charIndex+=1
              }
    }
   
  
}


