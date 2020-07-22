//
//  PhotoViewController.swift
//  500px
//
//  Created by Marc Santos on 2020-07-20.
//  Copyright © 2020 Marc Santos. All rights reserved.
//

import Foundation
import UIKit

class PhotoViewController: UIViewController {
    var photo: Photo!
    private var viewModel: PhotoViewModel!
    var photoView: PhotoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        viewModel = PhotoViewModel(photo: photo)
        setupPhotoView()
    }
    
    private func setupPhotoView() {
        photoView = PhotoView(frame: .zero)
        photoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(photoView)

        photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        photoView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        photoView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        photoView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true

        photoView.titleLabel.text = viewModel.title
        photoView.authorLabel.text = viewModel.authorText
        photoView.commentsLikesLabel.text = viewModel.commentsLikesText
        viewModel.avatarImage { [weak self] image in
            self?.photoView.avatarImageView.image = image
        }
        viewModel.photoImage { [weak self] image in
            self?.photoView.imageView.image = image
        }
    }
}
