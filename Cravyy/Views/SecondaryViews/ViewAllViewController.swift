//
//  ViewAllViewViewController.swift
//  Cravyy
//
//  Created by VD on 21/09/2021.
//

import UIKit
import Kingfisher
import ProgressHUD

class ViewAllViewViewController: UIViewController {
    
    
    @IBOutlet weak var vctitle: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var tag : Int?
    // tag that will be received from HomeViewController to decide wich array to use
    // tag = 0 (featured)
    //tag = 1 (nearyou)
    //tag = 2 (bestDeals)
    
    
    
    var featured : [restaurantsModel] = []
    var nearYou : [restaurantsModel] = []
    var bestDeals : [restaurantsModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ViewAllTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewAllCell")
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadContent()
         self.navigationController?.isNavigationBarHidden = false
    }
    
    func reloadContent(){
        tableView.reloadData()
        setVcTitle(tag!)
    }
    
    
    
   
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
       let cell = tableView.dequeueReusableCell(withIdentifier: "ViewAllCell", for: indexPath) as! ViewAllTableViewCell
        switch tag{
        case 0:
            cell.setup(restaurant: featured[indexPath.row], tag: 0)
            return cell
            
        case 1 :
            cell.setup(restaurant: nearYou[indexPath.row], tag: 1)
            return cell
        case 2:
            
            cell.setup(restaurant: bestDeals[indexPath.row], tag: 2)
            return cell
        default: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        switch tag{
        case 0:
            detailVC.restaurant = featured[indexPath.row]
        case 1 :
            detailVC.restaurant = nearYou[indexPath.row]
        case 2:
            detailVC.restaurant = bestDeals[indexPath.row]
           
        default: return
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
