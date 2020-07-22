//
//  AppSettings.swift
//  500px
//
//  Created by Marc Santos on 2020-07-12.
//  Copyright © 2020 Marc Santos. All rights reserved.
//

import Foundation

class AppSettings {
    struct Constants {
        static let envKey = "environment"
        static let settingsPlist = "Settings"
    }
    enum Environment: String {
        case prod
        case dev
    }

    static let shared = AppSettings()
    
    private init() {}
    
    func setEnvironment(_ env: Environment) {
        UserDefaults.standard.set(env.rawValue, forKey: Constants.envKey)
    }
    
    func environment() -> Environment {
        if let rawValue = UserDefaults.standard.string(forKey: Constants.envKey) {
            return Environment(rawValue: rawValue) ?? .dev
        } else {
            return .dev
        }
    }

    func plist() -> Plist {
        let url = Bundle.main.url(forResource: Constants.settingsPlist, withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as! Plist
        
        return plist
    }
}

