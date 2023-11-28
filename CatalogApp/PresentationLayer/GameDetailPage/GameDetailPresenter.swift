//
//  GameDetailPresenter.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 08/11/23.
//

import RAWGCorePackage

protocol GameDetailPresenterProtocol {
    var gameDetailView: GameDetailViewProtocol? { get set }
    var gameDetailInteractor: GameDetailInteractorProtocol? { get set }
    var gameDetailRouter: GameDetailRouterProtocol? { get set }

    func willFetchGameDetail()

    func willUpdateFavorite(_ gameDetailData: RAWGGameDetailModel)

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

    func willUpdateFavorite(_ gameDetailData: RAWGGameDetailModel) {
        FavoriteGameRealm.save(gameDetailData)
    }

    func willGoToGameWebsite(_ gameWebsite: String) {
        gameDetailRouter?.goToGameWebsite(gameWebsite)
    }
}
