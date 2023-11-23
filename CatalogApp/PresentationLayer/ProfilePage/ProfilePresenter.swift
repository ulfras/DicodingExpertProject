//
//  ProfilePresenter.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 08/11/23.
//

protocol ProfilePresenterProtocol {
    var profileView: ProfileViewProtocol? { get set }
    var profileInteractor: ProfileInteractorProtocol? { get set }
    var profileRouter: ProfileRouterProtocol? { get set }

    func willCheckDeveloperName()

    func willSaveDeveloperName(_ devName: String)
}

class ProfilePresenter: ProfilePresenterProtocol {
    var profileView: ProfileViewProtocol?

    var profileInteractor: ProfileInteractorProtocol?

    var profileRouter: ProfileRouterProtocol?

    init(profileView: ProfileViewProtocol, profileInteractor: ProfileInteractorProtocol) {
        self.profileView = profileView
        self.profileInteractor = profileInteractor
    }

    func willCheckDeveloperName() {
        if !DeveloperNameDefaults.check() {
            profileView?.showDeveloperName("Maulana Muhammad Yusuf Frasha")
        } else {
            let devName = DeveloperNameDefaults.get()
            profileView?.showDeveloperName(devName)
        }
    }

    func willSaveDeveloperName(_ devName: String) {
        DeveloperNameDefaults.save(devName)
        profileView?.showDeveloperName(devName)
    }
}
