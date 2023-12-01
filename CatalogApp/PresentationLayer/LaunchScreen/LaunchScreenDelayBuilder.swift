//
//  LaunchScreenDelayBuilder.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 14/11/23.
//

import UIKit
import RAWGCorePackage

class LaunchScreenDelayBuilder {

    static var storyBoard: UIStoryboard {
        return UIStoryboard(name: "LaunchScreenDelay", bundle: Bundle.main)
    }

    static func build(gameListRealmDataSource: GameListRealmDataSource) -> UIViewController {

        let dataSource = RAWGAPIDataSource()

        let view = storyBoard.instantiateViewController(withIdentifier: "LaunchScreenDelay") as! LaunchScreenDelayViewController
        let interactor = LaunchScreenDelayInteractor(
            launchScreenDelayDataSource: dataSource,
            gameListRealmDataSource: gameListRealmDataSource)
        let presenter = LaunchScreenDelayPresenter(launchScreenDelayView: view, launchScreenDelayInteractor: interactor)
        let router = LaunchScreenDelayRouter(launchScreenDelayViewController: view)

        view.launchScreenDelayPresenter = presenter
        interactor.launchScreenDelayPresenter = presenter
        presenter.launchScreenDelayRouter = router

        return view
    }
}
