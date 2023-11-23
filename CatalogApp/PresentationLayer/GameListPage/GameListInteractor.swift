//
//  GameListInteractor.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 08/11/23.
//

import Alamofire

protocol GameListInteractorProtocol {
    var gameListPresenter: GameListPresenterProtocol? { get set }

    func fetchGameDetail(id gameID: String, completionHandler: @escaping(Result<RAWGGameDetailModel, AFError>) -> Void)
}

class GameListInteractor: GameListInteractorProtocol {

    var gameListPresenter: GameListPresenterProtocol?

    let apiKey = RAWGAPI.apiKey

    func fetchGameDetail(id gameID: String, completionHandler: @escaping(Result<RAWGGameDetailModel, AFError>) -> Void) {
        RAWGAPI.getGameDetail(key: apiKey, id: gameID) { result in
            completionHandler(result)
        }
    }
}
