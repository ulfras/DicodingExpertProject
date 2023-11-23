//
//  LaunchScreenDelayPresenter.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 14/11/23.
//

protocol LaunchScreenDelayPresenterProtocol {
    var launchScreenDelayView: LaunchScreenDelayViewProtocol? { get set }
    var launchScreenDelayInteractor: LaunchScreenDelayInteractorProtocol? { get set }
    var launchScreenDelayRouter: LaunchScreenDelayRouterProtocol? { get set }

    func willFetchGameList()
}

class LaunchScreenDelayPresenter: LaunchScreenDelayPresenterProtocol {
    var launchScreenDelayView: LaunchScreenDelayViewProtocol?
    var launchScreenDelayInteractor: LaunchScreenDelayInteractorProtocol?
    var launchScreenDelayRouter: LaunchScreenDelayRouterProtocol?

    init(launchScreenDelayView: LaunchScreenDelayViewProtocol, launchScreenDelayInteractor: LaunchScreenDelayInteractorProtocol) {
        self.launchScreenDelayView = launchScreenDelayView
        self.launchScreenDelayInteractor = launchScreenDelayInteractor
    }

    func willFetchGameList() {
        launchScreenDelayInteractor?.fetchGameList(completionHandler: { result in
            switch result {
            case .success(let resultData):
                GameListDefaults.save(resultData)
                self.launchScreenDelayRouter?.goToGameList()
            case .failure(let error):
                self.launchScreenDelayView?.failedToFetchGameList(error.localizedDescription)
            }
        })
    }
}
