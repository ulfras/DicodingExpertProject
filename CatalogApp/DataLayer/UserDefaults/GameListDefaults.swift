//
//  GameListUserDefaults.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 14/11/23.
//

import Foundation

struct GameListDefaults {

    static let userDefaultsKey = "GameListDefaults"
    static let userDefaults = UserDefaults.standard

    static func save(_ value: RAWGGameListModel) {
        userDefaults.set(try? PropertyListEncoder().encode(value), forKey: userDefaultsKey)
    }

    static func get() -> RAWGGameListModel {
        var gameList: RAWGGameListModel!
        if let data = userDefaults.value(forKey: userDefaultsKey) as? Data {
            gameList = try? PropertyListDecoder().decode(RAWGGameListModel.self, from: data)
            return gameList
        } else {
            return gameList
        }
    }

    static func check() -> Bool {
        return userDefaults.object(forKey: userDefaultsKey) != nil
    }

    static func delete() {
        userDefaults.removeObject(forKey: userDefaultsKey)
    }
}
