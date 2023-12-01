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

    init(launchScreenDelayView: LaunchScreenDelayViewProtocol,
         launchScreenDelayInteractor: LaunchScreenDelayInteractorProtocol
    ) {
        self.launchScreenDelayView = launchScreenDelayView
        self.launchScreenDelayInteractor = launchScreenDelayInteractor
    }

    func willFetchGameListRx() {
        if launchScreenDelayInteractor!.checkGameListRealm() {
            launchScreenDelayRouter?.goToGameList()
        } else {
            launchScreenDelayInteractor?.fetchGameListRx()
                .observe(on: MainScheduler.instance)
                .subscribe { result in

                    var gameListEntityData: [GameListEntity] = []
                    var gameListData: GameListResults = GameListResults(results: gameListEntityData)

                    for data in result.results {
                        gameListEntityData.append(
                            GameListEntity(id: data.id,
                                           name: data.name,
                                           released: data.released,
                                           backgroundImage: data.backgroundImage,
                                           rating: data.rating))
                    }

                    self.launchScreenDelayInteractor?.saveGameFavoriteRealm(gameListData)
                    self.launchScreenDelayRouter?.goToGameList()
                } onError: { error in
                    self.launchScreenDelayView?.failedToFetchGameList(error.localizedDescription)
                }.disposed(by: disposeBag)
        }

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
