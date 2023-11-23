//
//  ProfileInteractor.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 08/11/23.
//

protocol ProfileInteractorProtocol {
    var profilePresenter: ProfilePresenterProtocol? { get set }
}

class ProfileInteractor: ProfileInteractorProtocol {
    var profilePresenter: ProfilePresenterProtocol?
}
