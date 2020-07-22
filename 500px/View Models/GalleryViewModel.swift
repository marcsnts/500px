//
//  GalleryViewModel.swift
//  500px
//
//  Created by Marc Santos on 2020-07-15.
//  Copyright © 2020 Marc Santos. All rights reserved.
//

import Foundation
import UIKit

protocol GalleryViewModelDelegate: class {
    func onFetchCompleted()
    func onFetchFailed()
}

class GalleryViewModel {
    private weak var delegate: GalleryViewModelDelegate?
    private var photos: [Photo] = []
    private var currentPage = 1
    private var isFetching = false
    var count: Int {
        return photos.count
    }
    
    init(delegate: GalleryViewModelDelegate) {
        self.delegate = delegate
    }
    
    func photo(at index: Int) -> Photo? {
        return index < photos.count ? photos[index] : nil
    }
    
    func fetchPhotos() {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        
        API.getPopularPhotos(page: currentPage) { photosData, error in
            DispatchQueue.main.async { [weak self] in
                defer {
                    self?.isFetching = false
                }
                guard let photosData = photosData, error == nil else {
                    self?.delegate?.onFetchFailed()
                    return
                }
                
                self?.photos.append(contentsOf: photosData.photos)
                self?.currentPage += 1
                self?.delegate?.onFetchCompleted()
            }
        }
    }
    
    func configure(cell: GalleryCollectionViewCell, at index: Int) {
        guard let photo = photo(at: index) else { return }
        
        cell.alpha = 0
        
        CacheManager.shared.loadImage(urlString: photo.imageURL) { image in
            cell.imageView.image = image
            UIView.animate(withDuration: 1) {
                cell.alpha = 1
            }
        }
    }
}
