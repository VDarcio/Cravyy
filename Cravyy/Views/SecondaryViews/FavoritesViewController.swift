//
//  FavoritesViewController.swift
//  Cravyy
//
//  Created by VD on 30/09/2021.
//

import UIKit
import CoreData
import Kingfisher

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableviews: UITableView!
    
    
    var favorites = [FavRest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableviews.register(UINib(nibName: "FetchedRestaurantsTableViewCell", bundle: nil), forCellReuseIdentifier: "FetchedCell")
        loadFavorites()
    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableviews.dequeueReusableCell(withIdentifier: "FetchedCell", for: indexPath) as! FetchedRestaurantsTableViewCell
        cell.setupFavorites(favorites[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableviews.deselectRow(at: indexPath, animated: true)
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        present(detailVC, animated: true, completion: nil)
        detailVC.setupFavorite(favorites[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // create swipe action
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            
            //what to remove
            let favoriteToRemove = self.favorites[indexPath.row]
            
            //remove
            self.context.delete(favoriteToRemove)
           
            do{
                try self.context.save()
            }catch{
                
            }
            self.loadFavorites()
            self.tableviews.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func loadFavorites(){
        
        let request : NSFetchRequest<FavRest> = FavRest.fetchRequest()
        
        do{
            favorites = try context.fetch(request)
            
        }catch{
            print("error loading \(error)")
        }
        tableviews.reloadData()
    }
   
}
    
    

