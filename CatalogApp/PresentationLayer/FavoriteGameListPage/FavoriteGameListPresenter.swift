//
//  FavoriteGameListPresenter.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 14/11/23.
//

import Foundation
import RAWGCorePackage

protocol FavoriteGameListPresenterProtocol {
    var favoriteGameListView: FavoriteGameListViewProtocol? { get set }
    var favoriteGameListInteractor: FavoriteGameListInteractorProtocol? { get set }
    var favoriteGameListRouter: FavoriteGameListRouterProtocol? { get set }

    func willFetchFavoriteGameList()

    func willFetchGameDetail(id gameID: Int)
}

class FavoriteGameListPresenter: FavoriteGameListPresenterProtocol {
    var favoriteGameListView: FavoriteGameListViewProtocol?
    var favoriteGameListInteractor: FavoriteGameListInteractorProtocol?
    var favoriteGameListRouter: FavoriteGameListRouterProtocol?

    init(favoriteGameListView: FavoriteGameListViewProtocol, favoriteGameListInteractor: FavoriteGameListInteractorProtocol) {
        self.favoriteGameListView = favoriteGameListView
        self.favoriteGameListInteractor = favoriteGameListInteractor
    }

    func willFetchFavoriteGameList() {
        let favoriteList = FavoriteGameRealm.get()
        print("favoriteList: \(favoriteList)")
        favoriteGameListView?.showFavoriteList(favoriteList)
    }

    func willFetchGameDetail(id gameID: Int) {
        if FavoriteGameRealm.check() {
            let favoriteList = FavoriteGameRealm.get()

            if let index = favoriteList.firstIndex(where: { $0.id == gameID }) {
                let data = favoriteList[index]
                self.favoriteGameListRouter?.goToGameDetailPage(gameData: data)
            }
        }
    }
}
