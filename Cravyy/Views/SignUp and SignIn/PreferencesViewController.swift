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
    var choices : [Category] = [
        .init(name: "Portuguese", image:UIImage(named: "Portuguese"), id: "10680"),
        .init(name: "Sushi", image: UIImage(named: "Sushi"), id: "10653"),
        .init(name: "Italian", image: UIImage(named: "pizza"), id: "4617"),
        .init(name: "Grill", image: UIImage(named: "Grill"), id: "10651"),
        .init(name: "Mexican", image: UIImage(named: "mexican"), id: "5110"),
        .init(name: "Fast Food", image: UIImage(named: "Fast food"), id: "10646"),
        .init(name: "Brazilian", image: UIImage(named: "brazillian"), id: "10348"),
        .init(name: "Bar food", image: UIImage(named: "bar food"), id: "10640")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier:"CategoryCell", for: indexPath) as! CategoriesTableViewCell
        cell.setup(choices[indexPath.row])
        
        
        
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
