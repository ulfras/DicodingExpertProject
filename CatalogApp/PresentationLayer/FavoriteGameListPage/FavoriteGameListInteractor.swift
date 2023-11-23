//
//  FavoriteGameListInteractor.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 14/11/23.
//

import Foundation

protocol FavoriteGameListInteractorProtocol {
    var favoriteGameListPresenter: FavoriteGameListPresenterProtocol? { get set }
}

class FavoriteGameListInteractor: FavoriteGameListInteractorProtocol {
    var favoriteGameListPresenter: FavoriteGameListPresenterProtocol?
}
