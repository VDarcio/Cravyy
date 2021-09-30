//
//  FavoritesViewController.swift
//  Cravyy
//
//  Created by VD on 30/09/2021.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableviews: UITableView!
    
    
    var favorites = [FavRest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadFavorites()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableviews.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath)
        cell.textLabel?.text = favorites[indexPath.row].name
        return cell
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
