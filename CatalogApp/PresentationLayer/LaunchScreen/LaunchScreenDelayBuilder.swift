//
//  LaunchScreenDelayBuilder.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 14/11/23.
//

import UIKit

class LaunchScreenDelayBuilder {

    static var storyBoard: UIStoryboard {
        return UIStoryboard(name: "LaunchScreenDelay", bundle: Bundle.main)
    }

    static func build() -> UIViewController {

        let view = storyBoard.instantiateViewController(withIdentifier: "LaunchScreenDelay") as! LaunchScreenDelayViewController
        let interactor = LaunchScreenDelayInteractor()
        let presenter = LaunchScreenDelayPresenter(launchScreenDelayView: view, launchScreenDelayInteractor: interactor)
        let router = LaunchScreenDelayRouter(launchScreenDelayViewController: view)

        view.launchScreenDelayPresenter = presenter
        interactor.launchScreenDelayPresenter = presenter
        presenter.launchScreenDelayRouter = router

        return view
    }
}
