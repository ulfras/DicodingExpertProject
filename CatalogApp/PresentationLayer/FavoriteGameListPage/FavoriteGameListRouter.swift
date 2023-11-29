//
//  FavoriteGameListRouter.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 14/11/23.
//

import UIKit
import RAWGCorePackage

protocol FavoriteGameListRouterProtocol {
    func goToGameDetailPage(gameData: RAWGGameDetailModel)
}

class FavoriteGameListRouter: FavoriteGameListRouterProtocol {

    weak var favoriteGameListViewController: UIViewController?

    init(favoriteGameListViewController: UIViewController) {
        self.favoriteGameListViewController = favoriteGameListViewController
    }

    func goToGameDetailPage(gameData: RAWGGameDetailModel) {

        let publisherName = [PublisherName(name: gameData.publishers.first!.name)]
        let developersName = [GameDeveloper(name: gameData.developers.first!.name)]
        let esrbRating = EsrbRating(name: gameData.esrbRating.name)

        let gameDetailData = GameDetailEntity(
            id: gameData.id,
            name: gameData.name,
            released: gameData.released,
            backgroundImage: gameData.backgroundImage,
            website: gameData.website,
            rating: gameData.rating,
            publishers: publisherName,
            developers: developersName,
            esrbRating: esrbRating,
            descriptionRaw: gameData.descriptionRaw,
            isFavorite: gameData.isFavorite
        )

        let gameDetailPage = GameDetailBuilder.build(gameData: gameDetailData)
        gameDetailPage.title = gameDetailData.name

        favoriteGameListViewController?.navigationController?.pushViewController(gameDetailPage, animated: true)
    }
}
