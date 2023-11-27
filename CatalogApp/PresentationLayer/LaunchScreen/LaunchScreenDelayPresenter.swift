//
//  LaunchScreenDelayPresenter.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 14/11/23.
//

import RxSwift
import RAWGCorePackage

protocol LaunchScreenDelayPresenterProtocol {
    var launchScreenDelayView: LaunchScreenDelayViewProtocol? { get set }
    var launchScreenDelayInteractor: LaunchScreenDelayInteractorProtocol? { get set }
    var launchScreenDelayRouter: LaunchScreenDelayRouterProtocol? { get set }

    func willFetchGameListRx()

    func willFetchGameList()
}

class LaunchScreenDelayPresenter: LaunchScreenDelayPresenterProtocol {

    var launchScreenDelayView: LaunchScreenDelayViewProtocol?

    var launchScreenDelayInteractor: LaunchScreenDelayInteractorProtocol?

    var launchScreenDelayRouter: LaunchScreenDelayRouterProtocol?

    private let disposeBag = DisposeBag()

    init(launchScreenDelayView: LaunchScreenDelayViewProtocol, launchScreenDelayInteractor: LaunchScreenDelayInteractorProtocol) {
        self.launchScreenDelayView = launchScreenDelayView
        self.launchScreenDelayInteractor = launchScreenDelayInteractor
    }

    func willFetchGameListRx() {
        launchScreenDelayInteractor?.fetchGameListRx()
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                GameListDefaults.save(result)
                self.launchScreenDelayRouter?.goToGameList()
            } onError: { error in
                self.launchScreenDelayView?.failedToFetchGameList(error.localizedDescription)
            }.disposed(by: disposeBag)
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
