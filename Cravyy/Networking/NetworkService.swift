//
//  NetworkService.swift
//  Cravyy
//
//  Created by VD on 22/09/2021.
//

import Foundation

protocol RestaurantsManagerDelegate{
    
    func didLoadRestaurants(_ service : NetworkService, restaurants: [restaurantsModel])
    func didFailedWithError(error:Error)
}

struct NetworkService{
    
    //static let shared = NetworkService()
    
    var delegate : RestaurantsManagerDelegate?
    
    
    
//    struct images:Codable{
//
//        var small:small
//    }
//
//
//    struct small:Codable{
//
//        var url:String?
//    }
//
    
    
     func fetchRestaurantsForCategory(_ id: String){
        
        let headers = [
            "x-rapidapi-host": "travel-advisor.p.rapidapi.com",
            "x-rapidapi-key": "7edd5a436fmshc0c6d2b91cbee85p1dc4e9jsn45edfc0ef7c5"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://travel-advisor.p.rapidapi.com/restaurants/list-by-latlng?latitude=38.7687&longitude=-9.16228&limit=30&currency=EUR&combined_food=\(id)&distance=5&open_now=false&lunit=km&lang=en_US")! as URL,
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
                print(httpResponse)
//                let responseString = String(data : data!, encoding: .utf8) ?? "could not turn into a string"
//                print("response = \(responseString)")
                let decoder = JSONDecoder()
                guard data != nil else{
                    print(AppError.serverError("no data"))
                    return}
                do{
                    let jsonRestaurants = try decoder.decode(Restaurants.self, from: data!)
                    print(jsonRestaurants)
                    let restaurantsFetched = jsonRestaurants.data
                    self.delegate!.didLoadRestaurants(self, restaurants: restaurantsFetched)
                    }catch{
                      print(AppError.errorDecoding)
                        self.delegate?.didFailedWithError(error: error)
                    }
            }
        })

        dataTask.resume()
        
        
    }
        
        
        
        
    
    
    
    
    
    
//    func fetchAllRestaurants(){
//
//        let headers = [
//            "x-rapidapi-host": "travel-advisor.p.rapidapi.com",
//            "x-rapidapi-key": "7edd5a436fmshc0c6d2b91cbee85p1dc4e9jsn45edfc0ef7c5"
//        ]
//
//        let request = NSMutableURLRequest(url: NSURL(string: "https://travel-advisor.p.rapidapi.com/restaurants/list-by-latlng?latitude=38.7687&longitude=-9.1622&limit=30&currency=EUR&distance=2&open_now=false&lunit=km&lang=en_US")! as URL,
//                                                cachePolicy: .useProtocolCachePolicy,
//                                            timeoutInterval: 10.0)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if (error != nil) {
//                print(error)
//            } else {
//                let httpResponse = response as? HTTPURLResponse
//                print(httpResponse)
////                let responseString = String(data : data!, encoding: .utf8) ?? "could not turn into a string"
////                print("response = \(responseString)")
//                let decoder = JSONDecoder()
//                guard data != nil else{
//                    print(AppError.serverError("no data"))
//                    return}
//                do{
//                    let jsonRestaurants = try decoder.decode(Restaurants.self, from: data!)
//                    print(jsonRestaurants)
//                    }catch{
//                      print(AppError.errorDecoding)
//                    }
//            }
//        })
//
//        dataTask.resume()
//
//
//    }
   
    
    
    
    
    
}
