//
//  FavoriteGameListPresenter.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 14/11/23.
//

import Foundation

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
        let favoriteList = favoriteGameListInteractor!.fetchFavoriteGameRealm()
        var favoriteListData: [FavoriteGameListEntity] = []

        for favoriteListDatum in favoriteList {
            favoriteListData.append(FavoriteGameListEntity(
                id: favoriteListDatum.id,
                name: favoriteListDatum.name,
                released: favoriteListDatum.released,
                backgroundImage: favoriteListDatum.backgroundImage,
                rating: favoriteListDatum.rating))
        }

        favoriteGameListView?.showFavoriteList(favoriteListData)
    }

    func willFetchGameDetail(id gameID: Int) {
        if favoriteGameListInteractor!.checkFavoriteGameRealm() {
            let favoriteList = favoriteGameListInteractor!.fetchFavoriteGameRealm()

            if let index = favoriteList.firstIndex(where: { $0.id == gameID }) {
                let data = favoriteList[index]
                self.favoriteGameListRouter?.goToGameDetailPage(gameData: data)
            }
        }
    }
}
