//
//  NetworkService.swift
//  Cravyy
//
//  Created by VD on 22/09/2021.
//

import Foundation


struct NetworkService{
    
    static let shared = NetworkService()
    
    struct restaurantsModel: Codable{
        var name, description, open_now_text,latitude,longitude: String?
       var photo : Photo?
        
       
    }
    
    struct Restaurants: Codable{
        var data: [restaurantsModel]
        
    }
    
    struct Photo:Codable{
       // var images: images
        //var uploaded_date: String //?
        var images: Images?
       
    }
    
    struct Images:Codable{
        var small: imageSize?
        
    }
    struct imageSize: Codable {
        
        var url: String?
        
    }
    
    
    
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
    
    
    
    
    
    func fetchAllRestaurants(){
        
        let headers = [
            "x-rapidapi-host": "travel-advisor.p.rapidapi.com",
            "x-rapidapi-key": "7edd5a436fmshc0c6d2b91cbee85p1dc4e9jsn45edfc0ef7c5"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://travel-advisor.p.rapidapi.com/restaurants/list-by-latlng?latitude=12.91285&longitude=100.87808&limit=3&currency=USD&distance=2&open_now=false&lunit=km&lang=en_US")! as URL,
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
                parse(Json: data!)
            }
        })

        dataTask.resume()
        
        
    }
    func parse(Json:Data){
        
        let decoder = JSONDecoder()
        do{
             let jsonrest = try decoder.decode(Restaurants.self, from: Json)
            
            print(jsonrest)
            }catch{
                print(Error.self)
            }
        
        
        
        
    }
    
    
    
    
    
}
