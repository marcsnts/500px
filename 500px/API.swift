//
//  API.swift
//  500px
//
//  Created by Marc Santos on 2020-07-12.
//  Copyright © 2020 Marc Santos. All rights reserved.
//

import Foundation

typealias Plist = [String: Any]

class API {
    struct Constants {
        static let settingsPlist = "Settings"
        static let consumerKeyPlist = "CONSUMER_KEY"
        static let consumerKeyHeader = "consumer_key"
        static let host = "api.500px.com"
        static let photos = "/v1/photos"
    }
    
    private static func consumerKey() -> String {
        let settings = AppSettings.shared.plist()
        let consumerKeyDict = settings[Constants.consumerKeyPlist] as? [String: String] ?? [:]
        return consumerKeyDict[AppSettings.shared.environment().rawValue] ?? ""
    }
    
    private static func baseURLRequestWith(path: String, queryItems: [String: String]? = nil) -> URLRequest? {
        var components = URLComponents()
        components.host = Constants.host
        components.path = path
        components.scheme = "https"
        if let queryItems = queryItems {
            components.queryItems = queryItems.map {
                return URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        
        guard let url = components.url else {
            return nil
        }
                
        var request = URLRequest(url: url)
        request.addValue(consumerKey(), forHTTPHeaderField: Constants.consumerKeyHeader)
        return request
    }
    
    static func getPopularPhotos(page: Int = 1, completion: (@escaping (PhotosData?, Error?) -> Void)) {
        let queryItems: [String: String] = [
            "feature": "popular",
            "image_size": "3",
            "rpp": "75",
            "page": "\(page)"
        ]
        let url = baseURLRequestWith(path: Constants.photos, queryItems: queryItems)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            let photosData = PhotosData(from: json)
            
            completion(photosData, error)
        }
        
        task.resume()
    }
}
