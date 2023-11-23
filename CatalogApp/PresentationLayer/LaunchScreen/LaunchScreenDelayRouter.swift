//
//  LaunchScreenDelayRouter.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 14/11/23.
//

import UIKit

protocol LaunchScreenDelayRouterProtocol {
    func goToGameList()
}

class LaunchScreenDelayRouter: LaunchScreenDelayRouterProtocol {

    weak var launchScreenDelayViewController: UIViewController?

    init(launchScreenDelayViewController: UIViewController) {
        self.launchScreenDelayViewController = launchScreenDelayViewController
    }

    func goToGameList() {
        let tabBarPage = TabBarViewController()
        tabBarPage.modalPresentationStyle = .fullScreen
        tabBarPage.modalTransitionStyle = .crossDissolve

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.launchScreenDelayViewController?.present(tabBarPage, animated: true)
        }
    }
}
