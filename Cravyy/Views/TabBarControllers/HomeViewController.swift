//
//  HomeViewController.swift
//  Cravyy
//
//  Created by VD on 16/09/2021.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var featuredCollectionView: UICollectionView!
    @IBOutlet weak var nearYouCollectionView: UICollectionView!
    @IBOutlet weak var BestDealsCollectionView: UICollectionView!
    var ViewAllVC : ViewAllViewViewController?
    
    
    //All arrays
    var restaurants : [Restaurants] = []
    var featured: [Featured] = [
        .init(name: "Mcdoalds", rating: "7.3/10", image: #imageLiteral(resourceName: "Untitled design")),
        .init(name: "Burguer King", rating: "3.3/10", image: #imageLiteral(resourceName: "cravyy_Icon-removebg-preview")),
        .init(name: "Guilty by olivier", rating: "9.3/10", image: #imageLiteral(resourceName: "Untitled design copy 2")),
        .init(name: "Carne moida", rating: "4.3/10", image: #imageLiteral(resourceName: "cravyy_Icon-removebg-preview")),
    ]
    var nearYou:[Nearyou] = [
        .init(name: "Frango no churrasco", distance: "3KM", image: #imageLiteral(resourceName: "Untitled design copy 2")),
        .init(name: "abelha", distance: "15KM", image: #imageLiteral(resourceName: "Untitled design copy")),
        .init(name: "sei la", distance: "3KM", image: #imageLiteral(resourceName: "Untitled design copy 2")),
        .init(name: "Frango no churrasco", distance: "3KM", image: #imageLiteral(resourceName: "Untitled design copy 2")),
        .init(name: "Frango no churrasco", distance: "3KM", image: #imageLiteral(resourceName: "Untitled design copy 2")),
        .init(name: "Frango no churrasco", distance: "3KM", image: #imageLiteral(resourceName: "Untitled design copy 2")),
        .init(name: "Frango no churrasco", distance: "3KM", image: #imageLiteral(resourceName: "Untitled design copy 2"))]
    var bestDeals:[BestDeals] = [
        .init(name: "Sushiiiiii", price: "25-60$", image: #imageLiteral(resourceName: "cravyy_Icon-removebg-preview")),
        .init(name: "Sushiiiiii", price: "25-60$", image: #imageLiteral(resourceName: "cravyy_Icon-removebg-preview")),
        .init(name: "Sushiiiiii", price: "25-60$", image: #imageLiteral(resourceName: "cravyy_Icon-removebg-preview"))]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
       //Instantiate ViewController that presents All the items
        ViewAllVC = storyboard?.instantiateViewController(identifier: "ViewAllVC") as! ViewAllViewViewController
        ViewAllVC?.modalPresentationStyle = .fullScreen
        ViewAllVC?.modalTransitionStyle = .coverVertical
        NetworkService.shared.fetchAllRestaurants()
    }
    
    
   
        
    @IBAction func viewAllPressed(_ sender: UIButton) {
        //switch thru all tags (0,1,2) to decide the information to be sent to the ViewAllViewController
        switch sender.tag{
        case 0 :
            //present the VC
            present(ViewAllVC!, animated: true, completion: nil)
            // set VC's tag as the same as our button
            ViewAllVC?.tag = sender.tag
            // Pass information according to our tag
             ViewAllVC?.featured = featured
        case 1 :
            present(ViewAllVC!, animated: true, completion: nil)
             ViewAllVC?.tag = sender.tag
             ViewAllVC?.nearYou = nearYou
        case 2:
            present(ViewAllVC!, animated: true, completion: nil)
             ViewAllVC?.tag = sender.tag
             ViewAllVC?.bestDeals = bestDeals
         default : return
        }
        
      
    
        
    }
    
   
    


}
//MARK:-TableView Delegates and dataSource
extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    
    
    //Register UiNib for every created cell
    func registerCells(){
        featuredCollectionView.register(UINib(nibName: "FeaturedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedCollectionViewCell")
        
        nearYouCollectionView.register(UINib(nibName: "NearYouCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NearYouCollectionViewCell")
        
        BestDealsCollectionView.register(UINib(nibName: "BestDealsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BestDealsCollectionViewCell")
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //switch thru all the collectionviews and return the count to poupulate the 3 collectionviews
        switch collectionView{
        case featuredCollectionView:
            return featured.count
        case nearYouCollectionView:
            return nearYou.count
        case BestDealsCollectionView:
            return bestDeals.count
        
        default:
            return 0
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
        case featuredCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCollectionViewCell", for: indexPath) as! FeaturedCollectionViewCell
            cell.setup(featured[indexPath.row])
            return cell
        case nearYouCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NearYouCollectionViewCell", for: indexPath) as! NearYouCollectionViewCell
            cell.setup(nearYou[indexPath.row])
            return cell
        case BestDealsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestDealsCollectionViewCell", for: indexPath) as! BestDealsCollectionViewCell
            cell.setup(bestDeals[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
        
        
        
        
        
    }
    
   
    }
 
    
    
    
    
    
    
    
    

