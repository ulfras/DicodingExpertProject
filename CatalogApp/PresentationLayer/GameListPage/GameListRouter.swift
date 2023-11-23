//
//  GameListRouter.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 08/11/23.
//

import UIKit

protocol GameListRouterProtocol {
    func goToGameDetailPage(gameData: RAWGGameDetailModel)
}

class GameListRouter: GameListRouterProtocol {
    weak var gameListViewController: UIViewController?

    init(gameListViewController: UIViewController) {
        self.gameListViewController = gameListViewController
    }

    func goToGameDetailPage(gameData: RAWGGameDetailModel) {
        let gameDetailPage = GameDetailBuilder.build(gameData: gameData)
        gameDetailPage.title = gameData.name

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.gameListViewController?.navigationController?.pushViewController(gameDetailPage, animated: true)
        }
    }
}
