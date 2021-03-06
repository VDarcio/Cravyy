//
//  DetailViewController.swift
//  Cravyy
//
//  Created by VD on 21/09/2021.
//

import UIKit
import ProgressHUD
import Kingfisher
import CoreData

class DetailViewController: UIViewController {

        //context used to access core data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //this 2 vars will either be aquired from a restaurant the user selects or from and old favorites the user added to favorites
    var restaurantLat : String?
    var restaurantLong : String?
    
    //MARK:-All Outlets
    var restaurant : restaurantsModel?
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

    @IBOutlet weak var addtoFavoritesLabel: UIButton!
    
    
    //TODO asign functions to all the labels
    override func viewDidLoad() {
        super.viewDidLoad()
        //print our coredata path
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        ProgressHUD.show()
        //setup the viewcontroller when the user selects a restaurant from the main menu or fetchedcategories
        VcSetup()
        //check if we have all properties, if we dont change the alpha to 0.0 to make it disapear
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
    func setupFavorite(_ favorite: FavRest){
        restaurantName.text = favorite.name
        restaurantAdress.text = favorite.adress
        restaurantDescription.text = favorite.descriptionn
        restaurantImageView.kf.setImage(with: favorite.photourl?.asURL)
        webSiteLabel.text = favorite.website
        restaurantPhoneNumber.text = favorite.phone
        addtoFavoritesLabel.setTitle("Added to Favorites", for: .normal)
        addtoFavoritesLabel.setImage(UIImage(systemName: "star.fill"), for: .normal)
        restaurantDistance.alpha = 0.0
        restaurantLat = favorite.lat
        restaurantLong = favorite.long
        
        
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
//        if restaurant?.website ==  nil{
//            webSiteLabel.alpha = 0.0
//        }
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
        restaurantRating.text = "??????\(restaurant?.rating ?? "")/5"
        restaurantDistance.text = "????\(restaurant?.distance_string ?? "")"
        restaurantDescription.text = restaurant?.description
        webSiteLabel.text = restaurant?.website
        restaurantPhoneNumber.text = restaurant?.phone
        restaurantPriceRange.text = "????\(restaurant?.price ?? "")"
        restaurantAdress.text = restaurant?.address
        
        restaurantLat = restaurant?.latitude
        restaurantLong = restaurant?.longitude
        
    }
    //this function is called when the users add the rstaurant to the favorites
    func changeFavoriteButton(){
        addtoFavoritesLabel.setTitle("Added to Favorites", for: .normal)
        addtoFavoritesLabel.setImage(UIImage(systemName: "star.fill"), for: .normal)
    }



    
  
//   Functions to deal with user interactions on labels and buttons
    @IBAction func CallRestaurant(){
        //make sure that is a number and remove the whitespaces to be compatible with type URL
        if let number = restaurantPhoneNumber.text?.removeWhitespace(){
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
        if let website = webSiteLabel.text{
            guard let url = URL(string: website) else { return }
            UIApplication.shared.open(url)
        }
        
    }
    @IBAction func getAdress(){
        let lat = self.restaurantLat
        let long = self.restaurantLong
        
        let url = URL(string: "maps://?saddr=&daddr=\(lat ?? ""),\(long ?? "")")
        if UIApplication.shared.canOpenURL(url!){
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
    
   
   
    
    //MARK:-Core Data Manager
    
    @IBAction func addtoFavoritesPressed(_ sender: Any) {
        changeFavoriteButton()
        
        //create a new favorite restaurant
        let newFavorite = FavRest(context: self.context)
        //add its properties
        newFavorite.name = self.restaurant?.name
        newFavorite.website = self.restaurant?.website
        newFavorite.phone = self.restaurant?.phone
        newFavorite.adress = self.restaurant?.address
        newFavorite.descriptionn = self.restaurant?.description
        newFavorite.photourl = self.restaurant?.photo?.images?.original?.url
        newFavorite.long = restaurant?.longitude
        newFavorite.lat = restaurant?.latitude
        //save to coreData
        self.saveItems()
        
    }
    
    func saveItems(){
        
        
        do{
            try context.save()
        }catch{
            print("error saving\(error)")
        }
    }
    


}
