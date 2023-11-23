//
//  GameListPresenter.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 08/11/23.
//

import Foundation

protocol GameListPresenterProtocol {
    var gameListView: GameListViewProtocol? { get set }
    var gameListInteractor: GameListInteractorProtocol? { get set }
    var gameListRouter: GameListRouterProtocol? { get set }

    func willFetchGameList()

    func willFetchGameDetail(id gameID: Int)
}

class GameListPresenter: GameListPresenterProtocol {

    var gameListView: GameListViewProtocol?

    var gameListInteractor: GameListInteractorProtocol?

    var gameListRouter: GameListRouterProtocol?

    init(gameListView: GameListViewProtocol, gameListInteractor: GameListInteractorProtocol) {
        self.gameListView = gameListView
        self.gameListInteractor = gameListInteractor
    }

    func willFetchGameList() {

        let gameListDataDefaults = GameListDefaults.get()

        var gameListData: [GameListEntity] = []

        for resultDatum in gameListDataDefaults.results {
            gameListData.append(
                GameListEntity(
                    id: resultDatum.id,
                    name: resultDatum.name,
                    released: resultDatum.released,
                    backgroundImage: resultDatum.backgroundImage,
                    rating: resultDatum.rating)
            )
        }

        gameListView?.showGameList(gameListData)
    }

    func willFetchGameDetail(id gameID: Int) {

        gameListView?.showLoadingScreen()

        if FavoriteGameDefaults.check() {

            let favoriteList = FavoriteGameDefaults.get()
            var foundMatch = false

            if let index = favoriteList.firstIndex(where: { $0.id == gameID }) {
                let data = favoriteList[index]

                self.gameListView?.dismissLoadingScreen()
                self.gameListRouter?.goToGameDetailPage(gameData: data)

                foundMatch = true
            }

            if !foundMatch {
                gameListInteractor?.fetchGameDetail(id: String(gameID), completionHandler: { result in
                    switch result {
                    case .success(let gameDetailData):
                        self.gameListView?.dismissLoadingScreen()
                        self.gameListRouter?.goToGameDetailPage(gameData: gameDetailData)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                })
            }
        } else {
            gameListInteractor?.fetchGameDetail(id: String(gameID), completionHandler: { result in
                switch result {
                case .success(let gameDetailData):
                    self.gameListView?.dismissLoadingScreen()
                    self.gameListRouter?.goToGameDetailPage(gameData: gameDetailData)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }
}
