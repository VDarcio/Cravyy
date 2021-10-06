//
//  File.swift
//  Cravyy
//
//  Created by VD on 23/09/2021.
//

import Foundation


enum AppError : LocalizedError{
    
    case errorDecoding
    case unknownError
    case invalidUrl
    case serverError(String)
    
    
    var errorDescription: String?{
        
        switch self{
        
        case .errorDecoding:
            return "response could not be decoded"
        case .unknownError:
           return "this is bad, this is very very bad"
        case .invalidUrl:
            return "Give me a valid URL"
        case .serverError(let error):
            return error
        }
    }
}

