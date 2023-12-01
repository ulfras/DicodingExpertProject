//
//  FavoriteGameListInteractor.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 14/11/23.
//

import RAWGCorePackage

protocol FavoriteGameListInteractorProtocol {
    var favoriteGameListPresenter: FavoriteGameListPresenterProtocol? { get set }

    var favoriteGameRealmDataSource: FavoriteGameRealmDataSource? { get set }

    func checkFavoriteGameRealm() -> Bool

    func fetchFavoriteGameRealm() -> [RAWGGameDetailModel]
}

class FavoriteGameListInteractor: FavoriteGameListInteractorProtocol {

    var favoriteGameListPresenter: FavoriteGameListPresenterProtocol?

    var favoriteGameRealmDataSource: FavoriteGameRealmDataSource?

    init(favoriteGameRealmDataSource: FavoriteGameRealmDataSource) {
        self.favoriteGameRealmDataSource = favoriteGameRealmDataSource
    }

    func checkFavoriteGameRealm() -> Bool {
        return favoriteGameRealmDataSource!.check()
    }

    func fetchFavoriteGameRealm() -> [RAWGGameDetailModel] {
        return favoriteGameRealmDataSource!.get()
    }
}
