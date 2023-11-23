//
//  GameDetailInteractor.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 08/11/23.
//

import Alamofire

protocol GameDetailInteractorProtocol {
    var gameDetailPresenter: GameDetailPresenterProtocol? { get set }
}

class GameDetailInteractor: GameDetailInteractorProtocol {
    var gameDetailPresenter: GameDetailPresenterProtocol?

}
