//
//  AppDelegate.swift
//  500px
//
//  Created by Marc Santos on 2020-07-12.
//  Copyright © 2020 Marc Santos. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        AppSettings.shared.setEnvironment(.dev)
        
        API.getPopularPhotos { photos, error in
            guard let photos = photos else { return }
            print(photos.currentPage)
            print(photos.totalPages)
            for photo in photos.photos {
                print(photo.name)
            }
        }
        
        return true
    }
}
