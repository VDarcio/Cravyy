//
//  HomeViewController.swift
//  Cravyy
//
//  Created by VD on 16/09/2021.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var featuredCollectionView: UICollectionView!
    
    var restaurants : [Restaurants] = [ .init(name: "Casa do Darcio", description: "Rio de janeiro, Brasil", image: #imageLiteral(resourceName: "cravyy_Icon-removebg-preview")),.init(name: "Casa do amilcar", description: " Brasil", image: #imageLiteral(resourceName: "Untitled design")),
                                        .init(name: "Casa da praia", description: "huambo", image: #imageLiteral(resourceName: "Untitled design copy 2")),
                                        .init(name: "Fim da CV", description: "Lisboaaa", image: #imageLiteral(resourceName: "Untitled design copy"))
                                        
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        featuredCollectionView.register(UINib(nibName: "FeaturedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedCollectionViewCell")
        
    }
    


}

extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCollectionViewCell", for: indexPath) as! FeaturedCollectionViewCell
        cell.setup(restaurants[indexPath.row])
        return cell
        
    }
    
    
    
    
    
    
    
}
