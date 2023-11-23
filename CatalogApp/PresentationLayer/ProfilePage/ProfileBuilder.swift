//
//  ProfileBuilder.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 08/11/23.
//

import UIKit

class ProfileBuilder {

    static var storyBoard: UIStoryboard {
        return UIStoryboard(name: "ProfilePage", bundle: Bundle.main)
    }

    static func build() -> UIViewController {
        let view = storyBoard.instantiateViewController(withIdentifier: "ProfilePage") as! ProfileViewController
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter(profileView: view, profileInteractor: interactor)
        let router = ProfileRouter(profileViewController: view)

        view.profilePresenter = presenter
        interactor.profilePresenter = presenter
        presenter.profileRouter = router

        return view
    }
}
