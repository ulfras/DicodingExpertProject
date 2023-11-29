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

    func willUpdateFavorite(_ gameDetailData: GameDetailEntity)

    func willGoToGameWebsite(_ gameWebsite: String)
}

class GameDetailPresenter: GameDetailPresenterProtocol {
    var gameDetailView: GameDetailViewProtocol?

    var gameDetailInteractor: GameDetailInteractorProtocol?

    var gameDetailRouter: GameDetailRouterProtocol?

    var gameDetailData: GameDetailEntity?

    init(gameDetailView: GameDetailViewProtocol, gameDetailInteractor: GameDetailInteractorProtocol, gameData: GameDetailEntity) {
        self.gameDetailView = gameDetailView
        self.gameDetailInteractor = gameDetailInteractor
        self.gameDetailData = gameData
    }

    func willFetchGameDetail() {
        guard let gameDetailData = gameDetailData else { return }
        gameDetailView?.showGameDetailData(gameDetailData: gameDetailData)
    }

    func willUpdateFavorite(_ gameDetailData: GameDetailEntity) {
        gameDetailInteractor?.saveGameFavoriteRealm(gameDetailData)
    }

    func willGoToGameWebsite(_ gameWebsite: String) {
        gameDetailRouter?.goToGameWebsite(gameWebsite)
    }
}
