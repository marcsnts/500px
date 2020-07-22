//
//  PhotoViewModel.swift
//  500px
//
//  Created by Marc Santos on 2020-07-20.
//  Copyright © 2020 Marc Santos. All rights reserved.
//

import Foundation
import UIKit

class PhotoViewModel {
    private var photo: Photo
    var title: String {
        return photo.name
    }
    var authorText: String {
        return "by " + photo.author
    }
    var commentsLikesText: String {
        return "\(photo.numLikes) likes  \(photo.numComments) comments"
    }
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    func photoImage(completion: @escaping ((UIImage?) -> Void)) {
        CacheManager.shared.loadImage(urlString: photo.imageURL) { image in
            completion(image)
        }
    }
    
    func avatarImage(completion: @escaping ((UIImage?) -> Void)) {
        CacheManager.shared.loadImage(urlString: photo.authorAvatarURL) { image in
            completion(image)
        }
    }
    
}
