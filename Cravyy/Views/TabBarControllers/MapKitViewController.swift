//
//  MapKitViewController.swift
//  Cravyy
//
//  Created by VD on 16/09/2021.
//

import UIKit
import MapKit
import CoreLocation

class MapKitViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
 let locationManager = CLLocationManager()
    
    // array of restaurants will be displayed on the map
    var restaurants : [restaurantsModel] = []
   

    override func viewDidLoad() {
        super.viewDidLoad()
        restaurants = HomeViewController.restaurantsclose
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        addAllPins()
        
        
        

    }
    //method to create add the pin on the map
    func addannotation(_ location : CLLocationCoordinate2D,_ title : String,_ subtitle :String){
      
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = title
        annotation.subtitle = subtitle
        
        mapView.addAnnotation(annotation)
        
    }
    
    func addPin(target: Int){
        //convert the coordinates to a double
       let lat = Double(restaurants[target].latitude!)
       let lon = Double(restaurants[target].longitude!)
            //add to the map using the restaurant data
        addannotation(CLLocationCoordinate2DMake(lat!, lon!), restaurants[target].name!, restaurants[target].distance_string!)
        
        
    }
    
    //loop all restaurants untill there is none left
    func addAllPins(){
        var target = 0
        while target < restaurants.count {
            addPin(target: target)
            target += 1
        }
    }
    
    
    
    
    
    

}
