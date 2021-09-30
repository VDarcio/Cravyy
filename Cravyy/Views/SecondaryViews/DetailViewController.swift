//
//  DetailViewController.swift
//  Cravyy
//
//  Created by VD on 21/09/2021.
//

import UIKit
import ProgressHUD
import Kingfisher

class DetailViewController: UIViewController {

    var userslat = HomeViewController.latitude
    var userslong = HomeViewController.longitude
    
    //MARK:-All Outlets
    var restaurant : restaurantsModel?
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var isOpenLabel: UILabel!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantRating: UILabel!
    @IBOutlet weak var restaurantDistance: UILabel!
    @IBOutlet weak var restaurantDescription: UITextView!
    
    @IBOutlet weak var bookMarkStar: UIButton!
    @IBOutlet weak var webSiteLabel: UILabel!
    var restaurantWebsite: String?
    @IBOutlet weak var restaurantPhoneNumber: UILabel!
    @IBOutlet weak var restaurantPriceRange: UILabel!
    @IBOutlet weak var restaurantAdress: UILabel!
    
    @IBOutlet weak var addtoFavoritesLabel: UIButton!
    
    
    //TODO asign functions to all the labels
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.show()
        VcSetup()
        checkStatus()
       
        //create gestures
        let phoneNumberTapped = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.CallRestaurant))
        let websiteTapped = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.openWebSite))
        let adressTapped = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.getAdress))
        //add gesture to all the labels needed
        restaurantPhoneNumber.addGestureRecognizer(phoneNumberTapped)
        restaurantAdress.addGestureRecognizer(adressTapped)
        webSiteLabel.addGestureRecognizer(websiteTapped)
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    func checkStatus(){
        if restaurant?.open_now_text == nil{
            isOpenLabel.alpha = 0.0
        }else if restaurant?.open_now_text != "Open Now"{
            isOpenLabel.backgroundColor = .red
        }
        if restaurant?.description == ""{
            restaurantDescription.text = "Restaurant has no information, we recommend visiting the website below"
        }
        if restaurant?.price == nil{
            restaurantPriceRange.alpha = 0.0
        }
        if restaurant?.rating ==  nil{
            restaurantRating.alpha = 0.0
        }
        if restaurant?.website ==  nil{
            webSiteLabel.alpha = 0.0
        }
        ProgressHUD.dismiss()
       
    }
    
    
    func VcSetup(){
        guard restaurant != nil else {return}
        
        if restaurant?.photo?.images?.original?.url != nil{
            restaurantImageView.kf.setImage(with: restaurant?.photo?.images?.original?.url?.asURL)
        }else{
            restaurantImageView.image = UIImage(named: "brazillian")
        }
        
        
        
        isOpenLabel.layer.cornerRadius = 10.0
        isOpenLabel.layer.masksToBounds = true
        //isOpenLabel.layer.borderColor = UIColor.black.cgColor
        //isOpenLabel.layer.borderWidth = 1.0
        
        restaurantName.text = restaurant?.name
        isOpenLabel.text = restaurant?.open_now_text
        restaurantRating.text = "⭐️\(restaurant?.rating ?? "")/5"
        restaurantDistance.text = "📍\(restaurant?.distance_string ?? "")"
        restaurantDescription.text = restaurant?.description
        webSiteLabel.text = restaurant?.website
        restaurantPhoneNumber.text = restaurant?.phone
        restaurantPriceRange.text = "💶\(restaurant?.price ?? "")"
        restaurantAdress.text = restaurant?.address
        
        
    }



    
  
//   Functions to deal with user interactions on labels and buttons
    @IBAction func CallRestaurant(){
        //make sure that is a number and remove the whitespaces to be compatible with type URL
        if let number = restaurant?.phone?.removeWhitespace(){
            //create url
            let urlAsString = URL(string: "tel://\(number)")
            //check if app can place the call
            if UIApplication.shared.canOpenURL(urlAsString!){
                //place the call
                UIApplication.shared.open(urlAsString!, options: [:], completionHandler: nil)
        }
        
        }
        
    }
    
    @IBAction func openWebSite(){
        if let website = restaurant?.website{
            guard let url = URL(string: website) else { return }
            UIApplication.shared.open(url)
        }
        
    }
    @IBAction func getAdress(){
        print("open google maps")
        let lat = restaurant?.latitude
        let long = restaurant?.longitude
        
        let url = URL(string: "maps://?saddr=&daddr=\(lat ?? ""),\(long ?? "")")
        if UIApplication.shared.canOpenURL(url!){
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
    
   
    @IBAction func bookmarkTapped(_ sender: Any) {
        bookMarkStar.setImage(UIImage(systemName: "star.fill"), for: .normal)
    }
    
  
    @IBAction func addtoFavoritesPressed(_ sender: Any) {
        
        addtoFavoritesLabel.setTitle("Added to Favorites", for: .normal)
        addtoFavoritesLabel.setImage(UIImage(systemName: "star.fill"), for: .normal)
    }
    


}
