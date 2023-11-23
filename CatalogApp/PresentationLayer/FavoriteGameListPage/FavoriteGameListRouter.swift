//
//  FavoriteGameListRouter.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 14/11/23.
//

import UIKit

protocol FavoriteGameListRouterProtocol {
    func goToGameDetailPage(gameData: RAWGGameDetailModel)
}

class FavoriteGameListRouter: FavoriteGameListRouterProtocol {

    weak var favoriteGameListViewController: UIViewController?

    init(favoriteGameListViewController: UIViewController) {
        self.favoriteGameListViewController = favoriteGameListViewController
    }

    func goToGameDetailPage(gameData: RAWGGameDetailModel) {
        let gameDetailPage = GameDetailBuilder.build(gameData: gameData)
        gameDetailPage.title = gameData.name

        favoriteGameListViewController?.navigationController?.pushViewController(gameDetailPage, animated: true)
    }
}
