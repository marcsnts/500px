//
//  PhotoView.swift
//  500px
//
//  Created by Marc Santos on 2020-07-21.
//  Copyright © 2020 Marc Santos. All rights reserved.
//

import Foundation
import UIKit

class PhotoView: UIView {
    let imageView: UIImageView
    let titleLabel: UILabel
    let authorLabel: UILabel
    let commentsLikesLabel: UILabel
    private let infoStackView: UIStackView
    let avatarImageView: UIImageView
    private let bottomView: UIView
    
    override init(frame: CGRect) {
        imageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            iv.translatesAutoresizingMaskIntoConstraints = false
            return iv
        }()
        
        bottomView = UIView()
        bottomView.backgroundColor = .black
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel = {
            let lbl = UILabel()
            lbl.text = "title"
            lbl.numberOfLines = 1
            lbl.font = .systemFont(ofSize: 17, weight: .semibold)
            lbl.textColor = .white
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        
        authorLabel = {
            let lbl = UILabel()
            lbl.numberOfLines = 1
            lbl.font = .systemFont(ofSize: 15)
            lbl.textColor = .white
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        
        commentsLikesLabel = {
            let lbl = UILabel()
            lbl.numberOfLines = 1
            lbl.font = .systemFont(ofSize: 14)
            lbl.textColor = .white
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()

        avatarImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            iv.clipsToBounds = true
            iv.layer.borderColor = UIColor.white.cgColor
            iv.layer.borderWidth = 1
            iv.layer.cornerRadius = 25
            iv.translatesAutoresizingMaskIntoConstraints = false
            return iv
        }()
        
        infoStackView = UIStackView(arrangedSubviews: [titleLabel, authorLabel, commentsLikesLabel])
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.axis = .vertical
        infoStackView.spacing = 0
        infoStackView.distribution = .fillEqually
        infoStackView.alignment = .fill
        
        super.init(frame: .zero)
        
        // Bottom View
        addSubview(bottomView)
        bottomView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        
        bottomView.addSubview(infoStackView)
        infoStackView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
        infoStackView.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 3/4).isActive = true
        infoStackView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        infoStackView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        
        bottomView.addSubview(avatarImageView)
        avatarImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        avatarImageView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        avatarImageView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor).isActive = true
        
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -12).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
