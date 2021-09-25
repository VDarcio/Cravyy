//
//  NetworkService.swift
//  Cravyy
//
//  Created by VD on 22/09/2021.
//

import Foundation
//Protocol that ViewController must conform as the delegate to get the data
protocol RestaurantsManagerDelegate{
    
    func didLoadRestaurants(_ service : NetworkService, restaurants: [restaurantsModel])
    func didFailedWithError(error:Error)
}

struct NetworkService{
    
   //delegate that viewcontroller must declare as self to acess this class
    var delegate : RestaurantsManagerDelegate?
    
   
    //MARK:-Fetch For Category
    
    //Method called from FetchedRestaurantsViewController to fetch all the restaurats from a specific category using the id of the category
    func fetchRestaurantsForCategory( id: String, lat :Double, lon :Double){
        
        let headers = [
            "x-rapidapi-host": "travel-advisor.p.rapidapi.com",
            "x-rapidapi-key": "7edd5a436fmshc0c6d2b91cbee85p1dc4e9jsn45edfc0ef7c5"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://travel-advisor.p.rapidapi.com/restaurants/list-by-latlng?latitude=\(lat)&longitude=\(lon)&limit=30&currency=EUR&combined_food=\(id)&distance=8&open_now=false&lunit=km&lang=en_US")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                //print(httpResponse)
//                let responseString = String(data : data!, encoding: .utf8) ?? "could not turn into a string"
//                print("response = \(responseString)")
                
                //initialize decoder
                let decoder = JSONDecoder()
                //make sure that is data
                guard data != nil else{
                    print(AppError.serverError("no data"))
                    return}
                do{
                    //decode the data into a restaurantmodel object
                    let jsonRestaurants = try decoder.decode(Restaurants.self, from: data!)
                    print(jsonRestaurants)
                    // declare decoded data to a constant
                    var restaurantsFetched = jsonRestaurants.data
                    //filter the array to remove all the objects that doesnt have a name
                    restaurantsFetched = (restaurantsFetched.filter({$0.name != nil}))
                    //call the delegate (FetchedRestaurantsViewController) and pass the data to it
                    self.delegate!.didLoadRestaurants(self, restaurants: restaurantsFetched)
                    }catch{
                      print(AppError.errorDecoding)
                        self.delegate?.didFailedWithError(error: error)
                    }
            }
        })

        dataTask.resume()
        
        
    }
    
    //MARK:-Fetch All Restaurants

        
    
    
    
}
