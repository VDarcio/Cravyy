//
//  RestaurantModel.swift
//  Cravyy
//
//  Created by VD on 23/09/2021.
//

import Foundation

struct restaurantsModel: Codable{
    var name, description, open_now_text,latitude,longitude, phone, website, address, price, rating, distance_string: String?
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
