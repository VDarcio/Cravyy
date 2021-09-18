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
    
    var restaurants : [Restaurants] = [ .init(name: "Casa do Darcio", description: "Rio de janeiro, Brasil", image: #imageLiteral(resourceName: "cravyy_Icon-removebg-preview")),.init(name: "Casa do amilcar", description: " Brasil", image: #imageLiteral(resourceName: "Untitled design")),
                                        .init(name: "A casa do pai dealguem grande aqui", description: "huambo", image: #imageLiteral(resourceName: "Untitled design copy 2")),
                                        .init(name: "Fim da CV", description: "Lisboaaa", image: #imageLiteral(resourceName: "Untitled design copy"))
                                        
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        featuredCollectionView.register(UINib(nibName: "FeaturedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedCollectionViewCell")
        nearYouCollectionView.register(UINib(nibName: "NearYouCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NearYouCollectionViewCell")
        BestDealsCollectionView.register(UINib(nibName: "BestDealsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BestDealsCollectionViewCell")
        
        
        
    }
    


}

extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView{
        case featuredCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCollectionViewCell", for: indexPath) as! FeaturedCollectionViewCell
            cell.setup(restaurants[indexPath.row])
            return cell
        case nearYouCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NearYouCollectionViewCell", for: indexPath) as! NearYouCollectionViewCell
            cell.setup(restaurants[indexPath.row])
            return cell
        case BestDealsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestDealsCollectionViewCell", for: indexPath) as! BestDealsCollectionViewCell
            cell.setup(restaurants[indexPath.row])
            return cell
            
        
        default:
            return UICollectionViewCell()
        }
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
}
