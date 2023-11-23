//
//  GameListInteractor.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 08/11/23.
//

import Alamofire
import RxSwift

protocol GameListInteractorProtocol {
    var gameListPresenter: GameListPresenterProtocol? { get set }
    
    var gameListDataSource: RAWGAPIDataSource? { get set }
    
    func fetchGameDetailRx(id gameID: String) -> Observable<RAWGGameDetailModel>

    func fetchGameDetail(id gameID: String, completionHandler: @escaping(Result<RAWGGameDetailModel, AFError>) -> Void)
}

class GameListInteractor: GameListInteractorProtocol {

    var gameListPresenter: GameListPresenterProtocol?
    
    var gameListDataSource: RAWGAPIDataSource?

    init(gameListDataSource: RAWGAPIDataSource) {
        self.gameListDataSource = gameListDataSource
    }

    func fetchGameDetailRx(id gameID: String) -> Observable<RAWGGameDetailModel> {
        return gameListDataSource!.getGameDetailRx(gameID: gameID)
    }
    
    func fetchGameDetail(id gameID: String, completionHandler: @escaping(Result<RAWGGameDetailModel, AFError>) -> Void) {
        gameListDataSource?.getGameDetail(gameID: gameID) { result in
            completionHandler(result)
        }
    }
}
