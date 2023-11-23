//
//  FavoriteGameDefaults.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 14/11/23.
//

import Foundation

struct FavoriteGameDefaults {

    static let userDefaultsKey = "FavoriteGameDefaults"
    static let userDefaults = UserDefaults.standard

    static func save(_ value: [RAWGGameDetailModel]) {
        userDefaults.set(try? PropertyListEncoder().encode(value), forKey: userDefaultsKey)
    }

    static func get() -> [RAWGGameDetailModel] {
        var favoriteGameList: [RAWGGameDetailModel]!
        if let data = userDefaults.value(forKey: userDefaultsKey) as? Data {
            favoriteGameList = try? PropertyListDecoder().decode([RAWGGameDetailModel].self, from: data)
            return favoriteGameList
        } else {
            return favoriteGameList
        }
    }

    static func check() -> Bool {
        return userDefaults.object(forKey: userDefaultsKey) != nil
    }

    static func delete() {
        userDefaults.removeObject(forKey: userDefaultsKey)
    }
}
