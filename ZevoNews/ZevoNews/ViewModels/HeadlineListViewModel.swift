//
//  HeadlineListViewModel.swift
//  ZevoNews
//
//  Created by Apple on 15/07/23.
//

import Foundation

protocol ErrorHandler: AnyObject {
    func handleError(message:String)
}

class HeadlineListViewModel{
    
    private var articlesData:ArticlesData?
    var articles:[Article]?{
        get{
            return self.articlesData?.articles
        }
    }
    var selectedCategory:Category = .all
    
    func selectCategory(atIndex:Int){
        let str = categories[atIndex].lowercased().trimmingCharacters(in: .whitespaces)
        selectedCategory = Category(rawValue: str) ?? .all
    }
    
    var categories = ["All ", " Business ", " Entertainment ", " General ", " Health ", " Science ", " Sports ", " Technology "]
    
    weak var errorHandlerDelegate:ErrorHandler?
    
    func getheadlines(category:Category, completion: @escaping (_ success:Bool)->()){
        APIManager.getHeadlinesData(category: category) { [self] success, errorMessage, data in
            if success{
                do {
                    if let tempData = data {
                        let decoder = JSONDecoder()
                        self.articlesData = try decoder.decode(ArticlesData.self, from: tempData)
                        completion(true)
                    }
                }catch let error {
                    completion(false)
                    self.errorHandlerDelegate?.handleError(message: error.localizedDescription)
                }
            }else if let errMsg = errorMessage {
                completion(false)
                self.errorHandlerDelegate?.handleError(message: errMsg)
            }
        }
    }
}
