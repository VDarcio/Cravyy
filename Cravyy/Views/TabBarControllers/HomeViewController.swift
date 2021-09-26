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
        //request user location
        locationManager.delegate=self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        //Register all the cells
        registerCells()
        
        //Instantiate ViewController that presents All the items
        //TODO: Attach this to a navigation controller
        ViewAllVC = storyboard?.instantiateViewController(identifier: "ViewAllVC") as! ViewAllViewViewController
        ViewAllVC?.modalPresentationStyle = .fullScreen
        ViewAllVC?.modalTransitionStyle = .coverVertical
        
        //Call networkservice to fetch all restaurants and place the data on all categories
        NetworkService.fetchAllRestaurants(latitude: 38.7687, Longitude: -9.1622) { restaurantsfetched in
            
          //  let featuredrestaurants = restaurantsfetched?.filter({$0.rating.})
            
           
          
            
            
            
            DispatchQueue.main.async {
                //divide the data in all categories
                self.featured = restaurantsfetched!
                self.nearYou = restaurantsfetched!
                self.bestDeals = restaurantsfetched!
                self.reloadViews()
                
                //call method to get location name
                self.lookUpCurrentLocation { placemark in
                    //display location name to the user
                    self.locationLabel.text = placemark?.name
                  
                    
                }
                
                ProgressHUD.dismiss()
            }
        }
    
    }
    //method to reload all the collectionviewa
    func reloadViews(){
        featuredCollectionView.reloadData()
        nearYouCollectionView.reloadData()
        BestDealsCollectionView.reloadData()
    }
    
    @IBAction func locatePressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    
    
//    @IBAction func viewAllPressed(_ sender: UIButton) {
//        //switch thru all tags (0,1,2) to decide the information to be sent to the ViewAllViewController
//        switch sender.tag{
//        case 0 :
//            //present the VC
//            present(ViewAllVC!, animated: true, completion: nil)
//            // set VC's tag as the same as our button
//            ViewAllVC?.tag = sender.tag
//            // Pass information according to our tag
//            ViewAllVC?.featured = featured
//        case 1 :
//            present(ViewAllVC!, animated: true, completion: nil)
//            ViewAllVC?.tag = sender.tag
//            ViewAllVC?.nearYou = nearYou
//        case 2:
//            present(ViewAllVC!, animated: true, completion: nil)
//            ViewAllVC?.tag = sender.tag
//            ViewAllVC?.bestDeals = bestDeals
//        default : return
//        }
//
//
//
//
//    }
    
    
    
    
    
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
            return featured.count
        case nearYouCollectionView:
            return nearYou.count
        case BestDealsCollectionView:
            return bestDeals.count
            
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            HomeViewController.latitude = lat
            HomeViewController.longitude = lon
            
            
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error locating\(error)")
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








