//
//  OnBoardingViewController.swift
//  Cravyy
//
//  Created by VD on 12/09/2021.
//

import UIKit

class OnBoardingViewController: UIViewController{
    
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControll: UIPageControl!
    
    
    //Slides that will be initalized by OnBoardingSlide
    var slides : [OnBoardingSlide] = []
    
    //settin the page control property to the current page number via computed properties
    var currentPage = 0 {
        didSet{
            pageControll.currentPage = currentPage
            //change the button if the user is in the last page
            if currentPage == slides.count - 1{
                nextButton.setTitle("Get Started", for: .normal)
                
            }else{
                nextButton.setTitle("Next", for: .normal)
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    //Give the properties to the slides
         slides = [
            OnBoardingSlide(title: "Nearby Restaurants", description: "You dont have to go far to find a good restaurant, we have provided all the restaraunts close to you", image: #imageLiteral(resourceName: "Untitled design")),
            OnBoardingSlide(title: "Tell us what you’re craving", description: "With the tap of a finger, get the best resturants nearby for the exact food you want right now", image: #imageLiteral(resourceName: "Untitled design copy")),
            OnBoardingSlide(title: "Get information on over +10.000 restaurants  across the world", description: "Get Contact details, Schedule, Menu,Booking info and much more before leaving your house", image: #imageLiteral(resourceName: "Untitled design copy 2"))
        ]
        //set the page control to adapt to any number of slides we desire to have
        pageControll.numberOfPages = slides.count
       
    }
    
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        //Navigate to the home page if the user taps next after the last page
        if currentPage == slides.count - 1{
            let controller = storyboard?.instantiateViewController(identifier: "FirstVC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true, completion: nil)
        }else{
            //if not, go to the next page
            currentPage += 1
           // get the CGRect of the index and then make that visible.
            let indexpath = IndexPath(item: currentPage, section: 0)
            let rect = CollectionView.layoutAttributesForItem(at: indexpath)?.frame
            CollectionView.scrollRectToVisible(rect!, animated: true)
           
        
    }
    

   

}
    
}
//MARK:-CollectionView Delegates and data source

extension OnBoardingViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnBoardingCell", for: indexPath) as! OnBoardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       //detect if the user has finished scrolling to update page control indicator
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
       
         
    }
    
}







