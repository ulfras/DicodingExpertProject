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

    var gameListAPIDataSource: RAWGAPIDataSourceProtocol? { get set }

    var gameListRealmDataSource: GameListRealmDataSource? { get set }

    var favoriteGameRealmDataSource: FavoriteGameRealmDataSource? { get set }

    func fetchGameListRealm() -> RAWGGameListModel?

    func checkFavoriteGameRealm() -> Bool

    func fetchFavoriteGameRealm() -> [RAWGGameDetailModel]

    func checkFavoriteDefault() -> Bool

    func fetchFavoriteGameDefault() -> [RAWGGameDetailModel]

    func fetchGameDetailRx(id gameID: String) -> Observable<RAWGGameDetailModel>

    func fetchGameDetail(id gameID: String, completionHandler: @escaping(Result<RAWGGameDetailModel, AFError>) -> Void)
}

class GameListInteractor: GameListInteractorProtocol {

    var gameListPresenter: GameListPresenterProtocol?

    var gameListAPIDataSource: RAWGAPIDataSourceProtocol?

    var gameListRealmDataSource: GameListRealmDataSource?

    var favoriteGameRealmDataSource: FavoriteGameRealmDataSource?

    init(gameListAPIDataSource: RAWGAPIDataSourceProtocol,
         gameListRealmDataSource: GameListRealmDataSource,
         favoriteGameRealmDataSource: FavoriteGameRealmDataSource) {
        self.gameListAPIDataSource = gameListAPIDataSource
        self.gameListRealmDataSource = gameListRealmDataSource
        self.favoriteGameRealmDataSource = favoriteGameRealmDataSource
    }

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

    func fetchGameListRealm() -> RAWGGameListModel? {
        return gameListRealmDataSource?.get()
    }

    func checkFavoriteGameRealm() -> Bool {
        return favoriteGameRealmDataSource!.check()
    }

    func fetchFavoriteGameRealm() -> [RAWGGameDetailModel] {
        return favoriteGameRealmDataSource!.get()
    }

    func checkFavoriteDefault() -> Bool {
        return FavoriteGameDefaults.check()
    }

    func fetchFavoriteGameDefault() -> [RAWGGameDetailModel] {
        return FavoriteGameDefaults.get()
    }

    func fetchGameDetailRx(id gameID: String) -> Observable<RAWGGameDetailModel> {
        return gameListAPIDataSource!.getGameDetailRx(apiKey: apiKey, gameID: gameID)
    }

    func fetchGameDetail(id gameID: String, completionHandler: @escaping(Result<RAWGGameDetailModel, AFError>) -> Void) {
        gameListAPIDataSource?.getGameDetail(apiKey: apiKey, gameID: gameID) { result in
            completionHandler(result)
        }
    }
}
