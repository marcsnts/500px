//
//  Modelss.swift
//  500px
//
//  Created by Marc Santos on 2020-07-12.
//  Copyright © 2020 Marc Santos. All rights reserved.
//

import Foundation

class PhotosData {
    private struct Constants {
        static let currentPage = "current_page"
        static let totalPages = "total_pages"
        static let photos = "photos"
        
    }
    let currentPage: Int
    let totalPages: Int
    let photos: [Photo]
    
    init(currentPage: Int, totalPages: Int, photos: [Photo]) {
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.photos = photos
    }
    
    convenience init(from dict: [String: Any]) {
        let currentPage = dict[Constants.currentPage] as! Int
        let totalPages = dict[Constants.totalPages] as! Int
        let photos: [Photo] = {
            let photosDict = dict[Constants.photos] as! [[String: Any]]
            return photosDict.map{Photo(from: $0)}
        }()
        
        self.init(currentPage: currentPage, totalPages: totalPages, photos: photos)
    }
}

class Photo {
    private struct Constants {
        static let name = "name"
        static let numComments = "comments_count"
        static let numLikes = "positive_votes_count"
        static let user = "user"
        static let fullName = "fullname"
        static let avatar = "userpic_url"
        static let images = "images"
        static let imageURL = "https_url"
    }
    let name: String
    let numComments: Int
    let numLikes: Int
    let author: String
    let authorAvatarURL: String
    let imageURL: String
    
    init(name: String, numComments: Int, numLikes: Int, author: String, authorAvatarURL: String, imageURL: String) {
        self.name = name
        self.numComments = numComments
        self.numLikes = numLikes
        self.author = author
        self.authorAvatarURL = authorAvatarURL
        self.imageURL = imageURL
    }
    
    convenience init(from dict: [String: Any]) {
        let name = dict[Constants.name] as! String
        let numComments = dict[Constants.numComments] as! Int
        let numLikes = dict[Constants.numLikes] as! Int
        let user = dict[Constants.user] as! [String: Any]
        let author = user[Constants.fullName] as! String
        let authorAvatarURL = user[Constants.avatar] as! String
        let images = dict[Constants.images] as! [[String: Any]]
        let imageURL = (images[0])[Constants.imageURL] as! String
        
        self.init(name: name, numComments: numComments, numLikes: numLikes, author: author, authorAvatarURL: authorAvatarURL, imageURL: imageURL)
    }
}
