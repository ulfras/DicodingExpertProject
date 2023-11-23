//
//  LaunchScreenDelayInteractor.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 14/11/23.
//

import Alamofire

protocol LaunchScreenDelayInteractorProtocol {
    var launchScreenDelayPresenter: LaunchScreenDelayPresenterProtocol? { get set }

    func fetchGameList(completionHandler: @escaping (Result<RAWGGameListModel, AFError>) -> Void)
}

class LaunchScreenDelayInteractor: LaunchScreenDelayInteractorProtocol {
    var launchScreenDelayPresenter: LaunchScreenDelayPresenterProtocol?

    let apiKey = RAWGAPI.apiKey

    func fetchGameList(completionHandler: @escaping (Result<RAWGGameListModel, AFError>) -> Void) {
        RAWGAPI.getGameList(key: apiKey) { result in
            completionHandler(result)
        }
    }
}
