//
//  GameListRouter.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 08/11/23.
//

import UIKit
import RAWGCorePackage

protocol GameListRouterProtocol {
    func goToGameDetailPage(gameData: RAWGGameDetailModel)
}

class GameListRouter: GameListRouterProtocol {
    weak var gameListViewController: UIViewController?

    init(gameListViewController: UIViewController) {
        self.gameListViewController = gameListViewController
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

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.gameListViewController?.navigationController?.pushViewController(gameDetailPage, animated: true)
        }
    }
}
