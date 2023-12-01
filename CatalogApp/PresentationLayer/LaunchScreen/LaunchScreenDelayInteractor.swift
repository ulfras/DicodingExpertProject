//
//  LaunchScreenDelayInteractor.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 14/11/23.
//

import Alamofire
import RxSwift
import RAWGCorePackage
import Foundation

protocol LaunchScreenDelayInteractorProtocol {
    var launchScreenDelayPresenter: LaunchScreenDelayPresenterProtocol? { get set }

    var launchScreenDelayDataSource: RAWGAPIDataSource? { get set }

    var gameListRealmDataSource: GameListRealmDataSource? { get set }

    func checkGameListRealm() -> Bool

    func saveGameFavoriteRealm(_ gameList: GameListResults)

    func fetchGameListRx() -> Observable<RAWGGameListModel>

    func fetchGameList(completionHandler: @escaping (Result<RAWGGameListModel, AFError>) -> Void)
}

class LaunchScreenDelayInteractor: LaunchScreenDelayInteractorProtocol {
    var launchScreenDelayPresenter: LaunchScreenDelayPresenterProtocol?

    var launchScreenDelayDataSource: RAWGAPIDataSource?

    var gameListRealmDataSource: GameListRealmDataSource?

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

    init(launchScreenDelayDataSource: RAWGAPIDataSource, gameListRealmDataSource: GameListRealmDataSource) {
        self.launchScreenDelayDataSource = launchScreenDelayDataSource
        self.gameListRealmDataSource = gameListRealmDataSource
    }

    func checkGameListRealm() -> Bool {
        gameListRealmDataSource!.check()
    }

    func saveGameFavoriteRealm(_ gameList: GameListResults) {
        do {
            let jsonData = try JSONEncoder().encode(gameList)

            let rawgGameListModel = try JSONDecoder().decode(
                RAWGGameListModel.self,
                from: jsonData
            )

            gameListRealmDataSource?.save(rawgGameListModel)
        } catch {
            print("Error encoding: \(error.localizedDescription)")
        }
    }

    func fetchGameListRx() -> Observable<RAWGGameListModel> {
        return launchScreenDelayDataSource!.getGameListRx(apiKey: apiKey)
    }

    func fetchGameList(completionHandler: @escaping (Result<RAWGGameListModel, AFError>) -> Void) {
        launchScreenDelayDataSource?.getGameList(apiKey: apiKey) { result in
            completionHandler(result)
        }
    }
}
