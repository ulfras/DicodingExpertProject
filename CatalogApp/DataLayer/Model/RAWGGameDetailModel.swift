//
//  RAWGGameDetailModel.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 09/11/23.
//

struct RAWGGameDetailModel: Codable {
    var id: Int
    var name: String
    var released: String
    var backgroundImage: String
    var website: String
    var rating: Double
    var publishers: [PublisherName]
    var developers: [GameDeveloper]
    var esrbRating: EsrbRating
    var descriptionRaw: String
    var isFavorite: Bool?

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

struct PublisherName: Codable {
    var name: String
}

struct GameDeveloper: Codable {
    var name: String
}

struct EsrbRating: Codable {
    var name: String
}
