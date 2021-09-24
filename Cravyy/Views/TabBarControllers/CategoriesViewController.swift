//
//  RandomViewController.swift
//  Cravyy
//
//  Created by VD on 16/09/2021.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    //Load all categories
    var categories : [Category] = [
        .init(name: "Portuguese", image:UIImage(named: "Portuguese"), id: "10680"),
        .init(name: "Sushi", image: UIImage(named: "Sushi"), id: "10653"),
        .init(name: "Italian", image: UIImage(named: "pizza"), id: "4617"),
        .init(name: "Grill", image: UIImage(named: "Grill"), id: "10651"),
        .init(name: "Mexican", image: UIImage(named: "mexican"), id: "5110"),
        .init(name: "Fast Food", image: UIImage(named: "Fast food"), id: "10646"),
        .init(name: "Brazilian", image: UIImage(named: "brazillian"), id: "10348"),
        .init(name: "Bar food", image: UIImage(named: "bar food"), id: "10640")
    
    ]
    
    var selectedCategory : [restaurantsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        
    }
    

    
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource{
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoriesTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.setup(categories[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       //get a reference to the category id to be used later
        guard let id = categories[indexPath.row].id else{
            print("no id for selected category")
            return
        }
        //use category id to fetch restaurants from the backend
        let FetchedRestaurantsVC = storyboard?.instantiateViewController(withIdentifier: "FetchedVC") as! FetchedRestaurantsViewController
        FetchedRestaurantsVC.restaurantid = id
        FetchedRestaurantsVC.selectedCat = categories[indexPath.row].name
        navigationController?.pushViewController(FetchedRestaurantsVC, animated: true)
        
    }
    
    
    
}
