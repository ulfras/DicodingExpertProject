//
//  FavoriteGameListInteractor.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 14/11/23.
//

import RAWGCorePackage

protocol FavoriteGameListInteractorProtocol {
    var favoriteGameListPresenter: FavoriteGameListPresenterProtocol? { get set }

    func checkFavoriteGameRealm() -> Bool

    func fetchFavoriteGameRealm() -> [RAWGGameDetailModel]
}

class FavoriteGameListInteractor: FavoriteGameListInteractorProtocol {
    var favoriteGameListPresenter: FavoriteGameListPresenterProtocol?

    func checkFavoriteGameRealm() -> Bool {
        return FavoriteGameRealm.check()
    }

    func fetchFavoriteGameRealm() -> [RAWGGameDetailModel] {
        return FavoriteGameRealm.get()
    }
}
