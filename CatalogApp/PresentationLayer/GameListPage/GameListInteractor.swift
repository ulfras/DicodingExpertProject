//
//  GameListInteractor.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 08/11/23.
//

import Alamofire
import RxSwift
import RAWGCorePackage
import Foundation

protocol GameListInteractorProtocol {
    var gameListPresenter: GameListPresenterProtocol? { get set }

    var gameListDataSource: RAWGAPIDataSource? { get set }

    func fetchGameDetailRx(id gameID: String) -> Observable<RAWGGameDetailModel>

    func fetchGameDetail(id gameID: String, completionHandler: @escaping(Result<RAWGGameDetailModel, AFError>) -> Void)
}

class GameListInteractor: GameListInteractorProtocol {

    var gameListPresenter: GameListPresenterProtocol?

    var gameListDataSource: RAWGAPIDataSource?

    var apiKey: String {
        guard let filePath = Bundle.main.path(forResource: "RAWG", ofType: "plist") else {

            guard Bundle.main.path(forResource: "RAWG-Sample", ofType: "plist") != nil else {
                fatalError("Couldn't find any file RAWG-Sample")
            }

            fatalError("Change the RAWG-Sample.plist to RAWG.plist and set the value with [APIKey:\"TheKey\"], to get \"TheKey\" go to https://rawg.io/apidocs")
        }

        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "APIKey") as? String else {
            fatalError("Couldn't find key 'APIKey' in 'RAWG.plist'.")
        }
        return value
    }

    init(gameListDataSource: RAWGAPIDataSource) {
        self.gameListDataSource = gameListDataSource
    }

    func fetchGameDetailRx(id gameID: String) -> Observable<RAWGGameDetailModel> {
        return gameListDataSource!.getGameDetailRx(apiKey: apiKey, gameID: gameID)
    }

    func fetchGameDetail(id gameID: String, completionHandler: @escaping(Result<RAWGGameDetailModel, AFError>) -> Void) {
        gameListDataSource?.getGameDetail(apiKey: apiKey, gameID: gameID) { result in
            completionHandler(result)
        }
    }
}
