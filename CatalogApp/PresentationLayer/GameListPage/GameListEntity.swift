//
//  GameListEntity.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 09/11/23.
//

struct GameListResults: Codable {
    let results: [GameListEntity]
}

struct GameListEntity: Codable {
    let id: Int
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Double
}
