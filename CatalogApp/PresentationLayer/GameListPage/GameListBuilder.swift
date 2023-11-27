//
//  GameListBuilder.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 08/11/23.
//

import UIKit
import RAWGCorePackage

class GameListBuilder {

    static var storyBoard: UIStoryboard {
        return UIStoryboard(name: "GameListPage", bundle: Bundle.main)
    }

    static func build() -> UIViewController {

        let dataSource = RAWGAPIDataSource()

        let view = storyBoard.instantiateViewController(withIdentifier: "GameListPage") as! GameListViewController
        let interactor = GameListInteractor(gameListDataSource: dataSource)
        let presenter = GameListPresenter(gameListView: view, gameListInteractor: interactor)
        let router = GameListRouter(gameListViewController: view)

        view.gameListPresenter = presenter
        interactor.gameListPresenter = presenter
        presenter.gameListRouter = router

        return view
    }
}
