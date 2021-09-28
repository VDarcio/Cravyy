//
//  HomeViewController.swift
//  Cravyy
//
//  Created by VD on 16/09/2021.
//

import UIKit
import CoreLocation
import ProgressHUD

class HomeViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    @IBOutlet weak var nearYouCollectionView: UICollectionView!
    @IBOutlet weak var BestDealsCollectionView: UICollectionView!
    static var restaurantsclose : [restaurantsModel] = [] // property to be sent to map to add anotations
    var ViewAllVC : ViewAllViewViewController?
    var locationManager = CLLocationManager()
    
    
    //static vars to be acessed from fetchedrestaurantsVc to send cordinates to networkservice
    static var latitude : Double?
    static var longitude : Double?
    
    
    
    //All arrays
    
    var featured: [restaurantsModel] = []
    var nearYou:[restaurantsModel] = []
    var bestDeals:[restaurantsModel] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.show()
        
        //Register all the cells
        registerCells()
        //request user location
        locationManager.delegate=self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        //Instantiate ViewController that presents All the items
        instantiateViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func instantiateViews(){
        
        
        //TODO: Attach this to a navigation controller
        ViewAllVC = storyboard?.instantiateViewController(identifier: "ViewAllVC") as? ViewAllViewViewController
        
        ViewAllVC?.modalPresentationStyle = .fullScreen
        ViewAllVC?.modalTransitionStyle = .coverVertical
        
        
    }
    //method to reload all the collectionviewa
    func reloadViews(){
        featuredCollectionView.reloadData()
        nearYouCollectionView.reloadData()
        BestDealsCollectionView.reloadData()
    }
    
    @IBAction func locatePressed(_ sender: UIButton) {
        ProgressHUD.show()
        locationManager.requestLocation()
    }
    
    
    
    @IBAction func viewAllPressed(_ sender: UIButton) {
        //switch thru all tags (0,1,2) to decide the information to be sent to the ViewAllViewController
        switch sender.tag{
            
        case 0 :
            
            // set VC's tag as the same as our button
            ViewAllVC?.tag = sender.tag
            // Pass information according to our tag
            ViewAllVC?.restaurants = self.featured
            //present the VC
            navigationController?.pushViewController(ViewAllVC!, animated: true)
            // ViewAllVC?.reloadContent()
            
        case 1 :
            ViewAllVC?.tag = sender.tag
            ViewAllVC?.restaurants = self.nearYou
            navigationController?.pushViewController(ViewAllVC!, animated: true)
            //ViewAllVC?.reloadContent()
            
        case 2:
            ViewAllVC?.tag = sender.tag
            ViewAllVC?.restaurants = self.bestDeals
            navigationController?.pushViewController(ViewAllVC!, animated: true)
            // ViewAllVC?.reloadContent()
            
        default : return
        }
        
        
        
        
    }
    
    
    
    
    
}
//MARK:-TableView Delegates and dataSource
extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    
    //Register UiNib for every created cell
    func registerCells(){
        featuredCollectionView.register(UINib(nibName: "FeaturedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedCollectionViewCell")
        
        nearYouCollectionView.register(UINib(nibName: "NearYouCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NearYouCollectionViewCell")
        
        BestDealsCollectionView.register(UINib(nibName: "BestDealsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BestDealsCollectionViewCell")
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //switch thru all the collectionviews and return the count to poupulate the 3 collectionviews
        switch collectionView{
        case featuredCollectionView:
            return  min(6, featured.count)//returns the minimum between 2 values
        case nearYouCollectionView:
            return   min(9, nearYou.count)  //returns the minimum between 2 values
        case BestDealsCollectionView:
            return   min(6, bestDeals.count) //returns the minimum between 2 values
            
        default:
            return 0
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
        case featuredCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCollectionViewCell", for: indexPath) as! FeaturedCollectionViewCell
            cell.setup(featured[indexPath.row])
            return cell
        case nearYouCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NearYouCollectionViewCell", for: indexPath) as! NearYouCollectionViewCell
            cell.setup(nearYou[indexPath.row])
            return cell
        case BestDealsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestDealsCollectionViewCell", for: indexPath) as! BestDealsCollectionViewCell
            cell.setup(bestDeals[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        switch collectionView{
            
        case featuredCollectionView:
            detailVC.restaurant = featured[indexPath.row]
            
        case nearYouCollectionView:
            detailVC.restaurant = nearYou[indexPath.row]
            
        case BestDealsCollectionView:
            detailVC.restaurant = bestDeals[indexPath.row]
            
        default:
            return
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    
}

//MARK:-Location Manager

extension HomeViewController:CLLocationManagerDelegate{
    //this method is called everytime the location is requested, it updates the location and calls the api to fetch restaurants in the area
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        ProgressHUD.show()
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            HomeViewController.latitude = lat
            HomeViewController.longitude = lon
            
            //Call networkservice to fetch all restaurants and place the data on all categories
            NetworkService.fetchAllRestaurants(latitude: lat, Longitude: lon) { [weak self] (restaurantsfetched) in
                
                
                
                
                
                //filter the array and separate the top rated restaurants
                let featuredret = restaurantsfetched?.filter({$0.rating == "5.0" || $0.rating == "4.9" || $0.rating == "4.8" || $0.rating == "4.7" || $0.rating == "4.6" || $0.rating == "4.5" || $0.rating == "4.4" || $0.rating == "4.3" || $0.rating == "4.2" || $0.rating == "4.1" || $0.rating == "4.0"})
                //update UI
                DispatchQueue.main.async {
                    //divide the data in all categories
                    ProgressHUD.dismiss()
                    self!.featured = featuredret!
                    self!.nearYou = restaurantsfetched!
                    self!.bestDeals = restaurantsfetched!
                    HomeViewController.restaurantsclose = restaurantsfetched! // property to be sent to map to add anotations
                    self!.featuredCollectionView.reloadData()
                    self!.nearYouCollectionView.reloadData()
                    self!.BestDealsCollectionView.reloadData()
                    
                    
                }
            }
            //call method to get location name
            self.lookUpCurrentLocation { [weak self] (placemark) in
                //display location name to the user
                DispatchQueue.main.async {
                    self!.locationLabel.text = placemark?.name
                }
                
                
            }
            
            
            
        }
        
        
        
    }
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error locating\(error)")
        ProgressHUD.showError("Failed to Locate")
    }
    
    //  Method to Get location name
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)-> Void ) {
        //tell the user that we are locating
        locationLabel.text = "Locating..."
        
        // Use the last reported location.
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
            
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                                            completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }
                else {
                    // An error occurred during geocoding.
                    completionHandler(nil)
                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }
    
}








