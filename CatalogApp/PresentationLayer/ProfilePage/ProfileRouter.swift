//
//  ProfileRouter.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 08/11/23.
//

import UIKit

protocol ProfileRouterProtocol {

}

class ProfileRouter: ProfileRouterProtocol {
    weak var profileViewController: UIViewController?

    init(profileViewController: UIViewController) {
        self.profileViewController = profileViewController
    }
}
