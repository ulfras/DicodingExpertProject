//
//  TabBarViewController.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 08/11/23.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let gameListViewController = setupGameListPage()
        let favoriteGameListViewController = setupFavoriteGameListPage()
        let profileViewController = setupProfilePage()

        self.viewControllers = [gameListViewController, favoriteGameListViewController, profileViewController]
    }
}

extension TabBarViewController {

    private func setupGameListPage() -> UINavigationController {

        let gameListPage = GameListBuilder.build()

        let listIcon = UIImage(systemName: "list.bullet")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemGray4)
        let selectedListImage = UIImage(systemName: "list.bullet")?.withRenderingMode(.alwaysOriginal).withTintColor(.dicoding)

        let gameListNavigationController = UINavigationController(rootViewController: gameListPage)

        gameListNavigationController.tabBarItem = UITabBarItem(title: "Game List", image: listIcon, selectedImage: selectedListImage)
        gameListNavigationController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.systemGray4], for: .normal)
        gameListNavigationController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)

        return gameListNavigationController
    }

    private func setupFavoriteGameListPage() -> UINavigationController {
        let favoriteGameListPage = FavoriteGameListBuilder.build()

        let listIcon = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemGray4)
        let selectedListImage = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.dicoding)

        let favoriteGameListNavigationController = UINavigationController(rootViewController: favoriteGameListPage)

        favoriteGameListNavigationController.tabBarItem = UITabBarItem(title: "Favorite List", image: listIcon, selectedImage: selectedListImage)
        favoriteGameListNavigationController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.systemGray4], for: .normal)
        favoriteGameListNavigationController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)

        return favoriteGameListNavigationController
    }

    private func setupProfilePage() -> UINavigationController {

        let profilePage = ProfileBuilder.build()

        let profileIcon = UIImage(systemName: "person.crop.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemGray4)
        let selectedProfileIcon = UIImage(systemName: "person.crop.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(.dicoding)

        let profileNavigationController = UINavigationController(rootViewController: profilePage)

        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: profileIcon, selectedImage: selectedProfileIcon)
        profileNavigationController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.systemGray4], for: .normal)
        profileNavigationController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)

        return profileNavigationController
    }
 }
