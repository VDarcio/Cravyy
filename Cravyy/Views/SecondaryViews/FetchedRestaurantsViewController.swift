//
//  FetchedRestaurantsViewController.swift
//  Cravyy
//
//  Created by VD on 23/09/2021.
//

import UIKit

class FetchedRestaurantsViewController: UIViewController {

    @IBOutlet weak var VCtitle: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    var networkservice = NetworkService()
    
    var restaurants : [restaurantsModel] = []
    
    var restaurantid : String?
    
    var selectedCat: String?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        networkservice.delegate = self
        tableview.register(UINib(nibName: "FetchedRestaurantsTableViewCell", bundle: nil), forCellReuseIdentifier: "FetchedCell")
        networkservice.fetchRestaurantsForCategory(restaurantid!)
        
        
        
    }
    
  
     
   

}


extension FetchedRestaurantsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("------------------------\(restaurants.count)--------------------")
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FetchedCell", for: indexPath ) as! FetchedRestaurantsTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.setup(restaurants[indexPath.row])
        return cell
    }
    
    
    
}

extension FetchedRestaurantsViewController: RestaurantsManagerDelegate{
   
    func didLoadRestaurants(_ service: NetworkService, restaurants: [restaurantsModel]) {
        self.restaurants = restaurants
        DispatchQueue.main.async {
            self.tableview.reloadData()
            self.title = self.selectedCat
        }
        
    }
    
    func didFailedWithError(error: Error) {
        print(error)
    }
    
    
    
}
