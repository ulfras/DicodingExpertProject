//
//  LaunchScreenDelayInteractor.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 14/11/23.
//

import Alamofire
import RxSwift

protocol LaunchScreenDelayInteractorProtocol {
    var launchScreenDelayPresenter: LaunchScreenDelayPresenterProtocol? { get set }
    
    var launchScreenDelayDataSource: RAWGAPIDataSource? { get set }

    func fetchGameListRx() -> Observable<RAWGGameListModel>
    
    func fetchGameList(completionHandler: @escaping (Result<RAWGGameListModel, AFError>) -> Void)
}

class LaunchScreenDelayInteractor: LaunchScreenDelayInteractorProtocol {
    var launchScreenDelayPresenter: LaunchScreenDelayPresenterProtocol?
    
    var launchScreenDelayDataSource: RAWGAPIDataSource?
    
    init(launchScreenDelayDataSource: RAWGAPIDataSource) {
        self.launchScreenDelayDataSource = launchScreenDelayDataSource
    }
    
    func fetchGameListRx() -> Observable<RAWGGameListModel> {
        return launchScreenDelayDataSource!.getGameListRx()
    }

    func fetchGameList(completionHandler: @escaping (Result<RAWGGameListModel, AFError>) -> Void) {
        launchScreenDelayDataSource?.getGameList() { result in
            completionHandler(result)
        }
    }
}
