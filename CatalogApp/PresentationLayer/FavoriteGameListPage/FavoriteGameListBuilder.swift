//
//  FavoriteGameListBuilder.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 14/11/23.
//

import UIKit
import RAWGCorePackage

class FavoriteGameListBuilder {

    static var storyBoard: UIStoryboard {
        return UIStoryboard(name: "FavoriteGameListPage", bundle: Bundle.main)
    }

    static func build(_ favoriteGameRealmDataSource: FavoriteGameRealmDataSource) -> UIViewController {
        let view = storyBoard.instantiateViewController(withIdentifier: "FavoriteGameList") as! FavoriteGameListViewController
        let interactor = FavoriteGameListInteractor(favoriteGameRealmDataSource: favoriteGameRealmDataSource)
        let presenter = FavoriteGameListPresenter(favoriteGameListView: view, favoriteGameListInteractor: interactor)
        let router = FavoriteGameListRouter(favoriteGameListViewController: view)

        view.favoriteGameListPresenter = presenter
        interactor.favoriteGameListPresenter = presenter
        presenter.favoriteGameListRouter = router

        return view
    }
}
