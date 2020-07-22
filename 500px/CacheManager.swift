//
//  CacheManager.swift
//  500px
//
//  Created by Marc Santos on 2020-07-20.
//  Copyright © 2020 Marc Santos. All rights reserved.
//

import Foundation
import UIKit

class CacheManager {
    static let shared = CacheManager()
    private let imageCache = NSCache<NSString, UIImage>()

    private init() {}
    
    func loadImage(urlString: String, completion: @escaping ((UIImage?) -> Void)) {
         if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            completion(cachedImage)
         } else if let url = URL(string: urlString) {
             let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                 guard let data = data, let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                
                self?.imageCache.setObject(image, forKey: urlString as NSString)
                
                DispatchQueue.main.async {
                    completion(image)
                }
             }

             task.resume()
         } else {
            completion(nil)
        }
    }
    
    func isImageCached(_ url: String) -> Bool {
        return imageCache.object(forKey: url as NSString) != nil
    }
    
}
