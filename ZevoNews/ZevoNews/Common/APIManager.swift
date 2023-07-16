//
//  APIManager.swift
//  ZevoNews
//
//  Created by Apple on 15/07/23.
//

import Foundation
import Alamofire



class APIManager{
        
    static func getHeadlinesData(category:Category, completion: @escaping (_ success:Bool, _ errorMessage:String?, _ data:Data?)->()) {
        DispatchQueue.global(qos: .background).async {
            
            let path = PathGenerator.getPathWith(taskType: .getHeadlines, category: category)
          
            let request = AF.request(path)
           
            request.response { (res) in
                if let err = res.error {
                    completion(false, err.errorDescription, nil)
                }else{
                    if let data = res.data{
                        completion(true, nil, data)
                    }
                }
            }
        }
    }
}
