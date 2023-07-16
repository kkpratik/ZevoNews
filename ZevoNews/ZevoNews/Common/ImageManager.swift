//
//  ImageManager.swift
//  ZevoNews
//
//  Created by Apple on 16/07/23.
//

import Foundation
import UIKit

class ImageManager{
    
    static let imageCache = NSCache<AnyObject, AnyObject>()
        
    // Associated Object property; implementation omitted.
    final private var imageUrl: URL?

    func loadImage(from urlString: String, placeholder: UIImage? = nil, completion:@escaping (UIImage?)->()) {

            guard let url = URL(string: urlString) else {
                return
            }

            imageUrl = url

            if let cachedImage = ImageManager.imageCache.object(forKey: url as AnyObject) as? UIImage {
                completion(cachedImage)
                return
            }

            self.get(url: url) { [weak self] (data, error) in
                guard let _imageUrl = self?.imageUrl, _imageUrl == url else {
                    return
                }                
                
                guard let data = data, let image = UIImage(data: data) else {
                    return
                }

                completion(image)
                ImageManager.imageCache.setObject(image, forKey: url as AnyObject)
            }
        }

    func get( url: URL, callback: @escaping (_ data: Data?, _ error: Error?) -> Void ) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            callback(data, error)
            }.resume()
    }
}
