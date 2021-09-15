//
//  PreferencesViewController.swift
//  Cravyy
//
//  Created by VD on 15/09/2021.
//

import UIKit

class PreferencesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var skipButton: UIButton!
    //var to keep track of how many item the user has chosen
    var foodsChosen = 0
    
    //items meant to populate tableview
    var choices : [Preferences] = [
        .init(foodName: "Burguer", foodImage: #imageLiteral(resourceName: "cravyy_Icon-removebg-preview")),
        .init(foodName: "pizza", foodImage: #imageLiteral(resourceName: "Untitled design")),
        .init(foodName: "pasta", foodImage: #imageLiteral(resourceName: "Untitled design copy 2")),
        .init(foodName: "sushi", foodImage: #imageLiteral(resourceName: "Untitled design copy")),
        .init(foodName: "nada", foodImage: #imageLiteral(resourceName: "cravyy_Icon-removebg-preview"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func skipbuttonTapped(_ sender: Any) {
        //if the user has chosen items, save to core data, else, skip to home viewcontroller
    }
    
}

extension PreferencesViewController: UITableViewDelegate, UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"MealsCell", for: indexPath)
        cell.imageView?.image = choices[indexPath.row].foodImage
        cell.textLabel?.text = choices[indexPath.row].foodName
        cell.accessoryType = .none
        
        
        return  cell
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //increase the number of items selected if user pressed on a cell that had no checkmark
        
        
//        foodsChosen += 1
//        if foodsChosen >= 1{
//            skipButton.setTitle("Continue", for: .normal)
//
//        }else{
//            skipButton.setTitle("Skip", for: .normal)
//        }
        //toDO: CoreData to keep track of users favorites
        
        
    }
    
    
    
    
}
