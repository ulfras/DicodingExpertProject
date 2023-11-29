//
//  GameDetailEntity.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 29/11/23.
//

public struct GameDetailEntity: Codable {
    public var id: Int
    public var name: String
    public var released: String
    public var backgroundImage: String
    public var website: String
    public var rating: Double
    public var publishers: [PublisherName]
    public var developers: [GameDeveloper]
    public var esrbRating: EsrbRating
    public var descriptionRaw: String
    public var isFavorite: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case backgroundImage = "background_image"
        case rating
        case website, publishers
        case esrbRating = "esrb_rating"
        case developers
        case descriptionRaw = "description_raw"
        case isFavorite
    }
}

public struct PublisherName: Codable {
    public var name: String
}

public struct GameDeveloper: Codable {
    public var name: String
}

public struct EsrbRating: Codable {
    public var name: String
}
