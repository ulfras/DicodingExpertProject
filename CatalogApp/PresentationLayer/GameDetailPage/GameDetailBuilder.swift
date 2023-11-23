//
//  GameDetailBuilder.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 08/11/23.
//

import UIKit

class GameDetailBuilder {

    static var storyBoard: UIStoryboard {
        return UIStoryboard(name: "GameDetailPage", bundle: Bundle.main)
    }

    static func build(gameData: RAWGGameDetailModel) -> UIViewController {
        let view = storyBoard.instantiateViewController(withIdentifier: "GameDetailPage") as! GameDetailViewController
        let interactor = GameDetailInteractor()
        let presenter = GameDetailPresenter(gameDetailView: view, gameDetailInteractor: interactor, gameData: gameData)
        let router = GameDetailRouter(gameDetailViewController: view)

        view.gameDetailPresenter = presenter
        interactor.gameDetailPresenter = presenter
        presenter.gameDetailRouter = router

        return view
    }
}
