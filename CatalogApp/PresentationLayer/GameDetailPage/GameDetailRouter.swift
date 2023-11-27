//
//  GameDetailRouter.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 08/11/23.
//

import UIKit
import SafariServices

protocol GameDetailRouterProtocol {
    func goToGameWebsite(_ gameWebsite: String)
}

class GameDetailRouter: GameDetailRouterProtocol {

    weak var gameDetailViewController: UIViewController?

    init(gameDetailViewController: UIViewController) {
        self.gameDetailViewController = gameDetailViewController
    }

    func goToGameWebsite(_ gameWebsite: String) {
        let gameWebURL = URL(string: gameWebsite)
        let safariViewController = SFSafariViewController(url: gameWebURL!)
        gameDetailViewController?.present(safariViewController, animated: true)
    }
}
