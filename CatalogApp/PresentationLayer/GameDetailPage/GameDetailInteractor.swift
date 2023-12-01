//
//  GameDetailInteractor.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 08/11/23.
//

import Alamofire
import RAWGCorePackage
import Foundation

protocol GameDetailInteractorProtocol {
    var gameDetailPresenter: GameDetailPresenterProtocol? { get set }

    var favoriteGameRealmDataSource: FavoriteGameRealmDataSource? { get set }

    func saveGameFavoriteRealm(_ favoritedGame: GameDetailEntity)
}

class GameDetailInteractor: GameDetailInteractorProtocol {

    var gameDetailPresenter: GameDetailPresenterProtocol?

    var favoriteGameRealmDataSource: RAWGCorePackage.FavoriteGameRealmDataSource?

    init(favoriteGameRealmDataSource: RAWGCorePackage.FavoriteGameRealmDataSource) {
        self.favoriteGameRealmDataSource = favoriteGameRealmDataSource
    }

    func saveGameFavoriteRealm(_ favoritedGame: GameDetailEntity) {
        do {
            let jsonData = try JSONEncoder().encode(favoritedGame)

            let rawgGameDetailModel = try JSONDecoder().decode(
                RAWGGameDetailModel.self,
                from: jsonData
            )

            favoriteGameRealmDataSource?.save(rawgGameDetailModel)
        } catch {
            print("Error encoding or decoding: \(error)")
        }
    }
}
