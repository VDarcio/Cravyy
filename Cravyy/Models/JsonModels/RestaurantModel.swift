//
//  RestaurantModel.swift
//  Cravyy
//
//  Created by VD on 23/09/2021.
//

import Foundation
//Decodable Process

//2nd
struct restaurantsModel: Codable{
    var name, description, open_now_text,latitude,longitude, phone, website, address, price, rating, distance_string: String?
   var photo : Photo?
    
   
   
}
//1st
struct Restaurants: Codable{
    var data: [restaurantsModel]
    
}

struct Photo:Codable{
   
    var images: Images?
   
}

struct Images:Codable{
    var original: imageSize?
    
}
struct imageSize: Codable {
    
    var url: String?
    
}
