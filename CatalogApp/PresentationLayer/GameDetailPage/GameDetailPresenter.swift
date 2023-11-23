//
//  GameDetailPresenter.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 08/11/23.
//

protocol GameDetailPresenterProtocol {
    var gameDetailView: GameDetailViewProtocol? { get set }
    var gameDetailInteractor: GameDetailInteractorProtocol? { get set }
    var gameDetailRouter: GameDetailRouterProtocol? { get set }

    func willFetchGameDetail()

    func willAddToFavorite(_ gameDetailData: RAWGGameDetailModel)

    func willRemoveFromFavorite(_ gameDetailID: Int)

    func willGoToGameWebsite(_ gameWebsite: String)
}

class GameDetailPresenter: GameDetailPresenterProtocol {
    var gameDetailView: GameDetailViewProtocol?

    var gameDetailInteractor: GameDetailInteractorProtocol?

    var gameDetailRouter: GameDetailRouterProtocol?

    var gameDetailData: RAWGGameDetailModel?

    init(gameDetailView: GameDetailViewProtocol, gameDetailInteractor: GameDetailInteractorProtocol, gameData: RAWGGameDetailModel) {
        self.gameDetailView = gameDetailView
        self.gameDetailInteractor = gameDetailInteractor
        self.gameDetailData = gameData
    }

    func willFetchGameDetail() {
        guard let gameDetailData = gameDetailData else { return }
        gameDetailView?.showGameDetailData(gameDetailData: gameDetailData)
    }

    func willAddToFavorite(_ gameDetailData: RAWGGameDetailModel) {
        if !FavoriteGameDefaults.check() {
            FavoriteGameDefaults.save([gameDetailData])
        } else {
            var favoriteGameList = FavoriteGameDefaults.get()
            favoriteGameList.append(gameDetailData)
            FavoriteGameDefaults.save(favoriteGameList)
        }
    }

    func willRemoveFromFavorite(_ gameDetailID: Int) {
        var favoriteList = FavoriteGameDefaults.get()

        if let indexToRemove = favoriteList.firstIndex(where: { $0.id == gameDetailID }) {
            favoriteList.remove(at: indexToRemove)
            FavoriteGameDefaults.save(favoriteList)
        }
    }

    func willGoToGameWebsite(_ gameWebsite: String) {
        gameDetailRouter?.goToGameWebsite(gameWebsite)
    }
}
