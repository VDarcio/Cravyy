//
//  ViewAllViewViewController.swift
//  Cravyy
//
//  Created by VD on 21/09/2021.
//

import UIKit
import Kingfisher
import ProgressHUD
import CoreData

class ViewAllViewViewController: UIViewController {
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var tag : Int?
    // tag that will be received from HomeViewController to decide wich array to use
    // tag = 0 (featured)
    //tag = 1 (nearyou)
    //tag = 2 (bestDeals)
    
    //use filtered array as the main array to display items
    var restaurants : [restaurantsModel] = []
    var filteredData : [restaurantsModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set the filtered array to have the same items as the restaurants array because the uses hasn't filtered yet
        filteredData = restaurants
        searchBar.delegate = self
        tableView.register(UINib(nibName: "ViewAllTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewAllCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadContent()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func reloadContent(){
        filteredData = restaurants
        searchBar.text = ""
        tableView.reloadData()
        setVcTitle(tag!)
    }
    
    //func that use the tag to determine what the title should be
    func setVcTitle(_ tag : Int){
        switch tag{
        case 0:
            title = "Featured"
        case 1 :
            title = "Near You"
        case 2:
            title = "Best deals"
            
        default: title = ""
            
        }
    }
    
    
    //dismiss the VC when the returnButton is pressed
    @IBAction func returnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ViewAllViewViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    //use the tag we got from HomeVc to decide wich detail to use
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewAllCell", for: indexPath) as! ViewAllTableViewCell
        switch tag{
        case 0:
            cell.setup(restaurant: filteredData[indexPath.row], tag: 0)
            return cell
            
        case 1 :
            cell.setup(restaurant: filteredData[indexPath.row], tag: 1)
            return cell
        case 2:
            
            cell.setup(restaurant: filteredData[indexPath.row], tag: 2)
            return cell
        default: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        tableView.deselectRow(at: indexPath, animated: true)
        detailVC.restaurant = filteredData[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
//MARK:-SearchBar Delegates

extension ViewAllViewViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //empty the array
        filteredData = []
        
        //set the array to present all restaurants if the searchbar is empty
        if searchText == ""{
            filteredData = restaurants
        }
        else{
            //loop thru all restaurants to see if it matches users serach and present the ones that do
            for restaurant in restaurants{
                
                if restaurant.name!.lowercased().contains(searchText.lowercased()){
                    
                    filteredData.append(restaurant)
                }
            }
        }
        self.tableView.reloadData()
        
    }
    
    
}
