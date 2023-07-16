//
//  Constants.swift
//  ZevoNews
//
//  Created by Apple on 15/07/23.
//

import Foundation

enum Category:String{
    case all, business, entertainment, general, health, science, sports, technology
}

enum TaskType:String{
    case getHeadlines = "/v2/top-headlines?"
}

class Constants{
    
    static let baseUrl = "https://newsapi.org"
    static let country = "us"
    static let apiKey = "791d68b7099e45f392acb5caaa593679"
}

class PathGenerator{
    
    static func getPathWith(taskType:TaskType, category:Category = .all) -> String{
        
        var path = Constants.baseUrl + taskType.rawValue + "country=" + Constants.country
        
        if category != .all{
            path += "&category=\(category.rawValue)"
        }
        path += "&apikey=\(Constants.apiKey)"
        
        return  path
    }
}
