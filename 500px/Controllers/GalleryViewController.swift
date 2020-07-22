//
//  GalleryViewController.swift
//  500px
//
//  Created by Marc Santos on 2020-07-15.
//  Copyright © 2020 Marc Santos. All rights reserved.
//

import Foundation
import UIKit

class GalleryViewController: UIViewController {
    private var viewModel: GalleryViewModel!
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 1
        layout.footerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier)
        cv.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
        return cv
    }()
    private let footerSpinner = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Popular"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupCollectionView()
        
        viewModel = GalleryViewModel(delegate: self)
        viewModel.fetchPhotos()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}

extension GalleryViewController: GalleryViewModelDelegate {
    func onFetchCompleted() {
        collectionView.reloadData()
    }
    
    func onFetchFailed() {
        
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 4 - 1
        return CGSize(width: width, height: width)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier, for: indexPath) as! GalleryCollectionViewCell
        viewModel.configure(cell: cell, at: indexPath.row)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photo = viewModel.photo(at: indexPath.row) else { return }
        
        let photoVc = PhotoViewController()
        photoVc.photo = photo
        present(photoVc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter else {
            return UICollectionReusableView()
        }
        
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
        footer.addSubview(footerSpinner)
        
        footerSpinner.center = footer.center
        footer.addSubview(footerSpinner)
        footerSpinner.frame = CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: 50)
        footerSpinner.startAnimating()
        
        return footer
    }
}

extension GalleryViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPos = scrollView.contentOffset.y
        // Bottom of the collection view
        if yPos > collectionView.contentSize.height - 100 - scrollView.frame.size.height {
            viewModel.fetchPhotos()
        }
    }
}

