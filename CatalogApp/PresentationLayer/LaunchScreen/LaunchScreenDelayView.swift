//
//  LaunchScreenDelay.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 14/11/23.
//

import UIKit

protocol LaunchScreenDelayViewProtocol {
    var launchScreenDelayPresenter: LaunchScreenDelayPresenterProtocol? { get set }

    func failedToFetchGameList(_ errorString: String)
}

class LaunchScreenDelayViewController: UIViewController {

    var launchScreenDelayPresenter: LaunchScreenDelayPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        launchScreenDelayPresenter?.willFetchGameList()
    }
}

extension LaunchScreenDelayViewController: LaunchScreenDelayViewProtocol {

    func failedToFetchGameList(_ errorString: String) {
        let alert = UIAlertController(title: "Error", message: "Failed to fetch game list: \(errorString)", preferredStyle: .alert)

        let retryButton = UIAlertAction(title: "Retry", style: .default) { _ in
            self.launchScreenDelayPresenter?.willFetchGameList()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)

        alert.addAction(retryButton)
        alert.addAction(cancelButton)

        self.present(alert, animated: true)
    }
}
