//
//  ViewAllViewViewController.swift
//  Cravyy
//
//  Created by VD on 21/09/2021.
//

import UIKit

class ViewAllViewViewController: UIViewController {
    
    
    @IBOutlet weak var tagTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var tag : Int?
    // tag that will be received from HomeViewController to decide wich array to use
    // tag = 0 (featured)
    //tag = 1 (nearyou)
    //tag = 2 (bestDeals)
    
    
    //var restaurants : [Restaurants] = []
    var featured : [Featured] = []
    var nearYou : [Nearyou] = []
    var bestDeals : [BestDeals] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //func that use the tag to determine what the title should be
    func setVcTitle(_ tag : Int){
        switch tag{
        case 0:
            tagTitle.text = "Featured"
        case 1 :
            tagTitle.text = "Near You"
        case 2:
            tagTitle.text = "Best deals"
            
        default: tagTitle.text = "Nadadadad"
            
        }
    }
    
    //reload tableview everytime the view reappears to change items
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
        setVcTitle(tag!)
    }
    
    //dismiss the VC when the returnButton is pressed
    @IBAction func returnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ViewAllViewViewController: UITableViewDelegate, UITableViewDataSource{
    //use the tag we got from HomeVc to decide wich array to use
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tag{
        case 0: return featured.count
        case 1 : return nearYou.count
        case 2: return bestDeals.count
            
        default: return 0
        
        }
    }
    //use the tag we got from HomeVc to decide wich array to use
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "ViewAllCell", for: indexPath)
        switch tag{
        case 0:
            cell.textLabel?.text = featured[indexPath.row].name
            cell.imageView?.image = featured[indexPath.row].image
            cell.detailTextLabel?.text = featured[indexPath.row].rating
            return cell
        case 1 :
            cell.textLabel?.text = nearYou[indexPath.row].name
            cell.imageView?.image = nearYou[indexPath.row].image
            cell.detailTextLabel?.text = nearYou[indexPath.row].distance
            return cell
        case 2:
            cell.textLabel?.text = bestDeals[indexPath.row].name
            cell.imageView?.image = bestDeals[indexPath.row].image
            cell.detailTextLabel?.text = bestDeals[indexPath.row].price
            return cell
        default: return UITableViewCell()
        }
    }
}
