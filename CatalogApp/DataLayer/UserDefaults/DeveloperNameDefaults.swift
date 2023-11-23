//
//  DeveloperNameDefaults.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 14/11/23.
//

import Foundation

struct DeveloperNameDefaults {
    static let devNameDefaultsKey = "DeveloperNameDefaults"
    static let userDefaults = UserDefaults.standard

    static func save(_ value: String) {
        userDefaults.set(value, forKey: devNameDefaultsKey)
    }

    static func get() -> String {
        return userDefaults.string(forKey: devNameDefaultsKey)!
    }

    static func check() -> Bool {
        return userDefaults.object(forKey: devNameDefaultsKey) != nil
    }
}
