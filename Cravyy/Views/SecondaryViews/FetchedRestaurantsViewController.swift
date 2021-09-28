//
//  FetchedRestaurantsViewController.swift
//  Cravyy
//
//  Created by VD on 23/09/2021.
//

import UIKit
import ProgressHUD

class FetchedRestaurantsViewController: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    var networkservice = NetworkService()
    
    var filteredRestaurants : [restaurantsModel] = []
    var restaurants : [restaurantsModel] = []
    
    var restaurantid : String?
    
    var selectedCat: String?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredRestaurants = restaurants
        searchBar.delegate = self
        ProgressHUD.show()
        networkservice.delegate = self
        tableview.register(UINib(nibName: "FetchedRestaurantsTableViewCell", bundle: nil), forCellReuseIdentifier: "FetchedCell")
        networkservice.fetchRestaurantsForCategory(id: restaurantid!, lat: HomeViewController.latitude!, lon: HomeViewController.longitude!)
        
        
    }
    
    
    
    
    
}


extension FetchedRestaurantsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRestaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FetchedCell", for: indexPath ) as! FetchedRestaurantsTableViewCell
        //cell.accessoryType = .disclosureIndicator
        cell.setup(filteredRestaurants[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        detailVC.restaurant = filteredRestaurants[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
}

extension FetchedRestaurantsViewController: RestaurantsManagerDelegate{
    
    func didLoadRestaurants(_ service: NetworkService, restaurants: [restaurantsModel]) {
        self.restaurants = restaurants
        self.filteredRestaurants = restaurants
        DispatchQueue.main.async {
            self.tableview.reloadData()
            self.title = self.selectedCat
            ProgressHUD.dismiss()
        }
        
    }
    
    func didFailedWithError(error: Error) {
        ProgressHUD.showError(error.localizedDescription)
        print(error)
    }
    
    
    
}

//MARK:-SearchBar Delegates

extension FetchedRestaurantsViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredRestaurants = []
        
        if searchText == ""{
            filteredRestaurants = restaurants
        }
        else{
            for rest in restaurants{
                if
                    rest.name!.lowercased().contains(searchText.lowercased()){
                    filteredRestaurants.append(rest)
                }
            }
        }
        self.tableview.reloadData()
    }
}
