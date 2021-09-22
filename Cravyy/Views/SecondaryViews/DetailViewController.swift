//
//  DetailViewController.swift
//  Cravyy
//
//  Created by VD on 21/09/2021.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK:-All Outlets
    @IBOutlet weak var VCtitle: UILabel!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var isOpenLabel: UILabel!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantRating: UILabel!
    @IBOutlet weak var restaurantDistance: UILabel!
    @IBOutlet weak var restaurantDescription: UITextView!
    
    @IBOutlet weak var webSiteLabel: UILabel!
    var restaurantWebsite: String?
    @IBOutlet weak var restaurantPhoneNumber: UILabel!
    @IBOutlet weak var restaurantPriceRange: UILabel!
    @IBOutlet weak var restaurantAdress: UILabel!
    
    
    //TODO asign functions to all the labels
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //create gestures
        let phoneNumberTapped = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.CallRestaurant))
        let websiteTapped = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.openWebSite))
        let adressTapped = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.getAdress))
        //add gesture to all the labels needed
        restaurantPhoneNumber.addGestureRecognizer(phoneNumberTapped)
        restaurantAdress.addGestureRecognizer(adressTapped)
        webSiteLabel.addGestureRecognizer(websiteTapped)
        
        
        
    }
    
    
  
//   Functions to deal with user interactions on labels and buttons
    @IBAction func CallRestaurant(){
        print("phone number")
    }
    
    @IBAction func openWebSite(){
        print("www.facevoo.com")
    }
    @IBAction func getAdress(){
        print("open google maps")
    }
    

}
