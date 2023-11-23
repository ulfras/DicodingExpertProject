//
//  FavoriteGameListView.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 14/11/23.
//

import UIKit

protocol FavoriteGameListViewProtocol {
    var favoriteGameListPresenter: FavoriteGameListPresenterProtocol? { get set }

    func showFavoriteList(_ favoriteList: [RAWGGameDetailModel])
}

class FavoriteGameListViewController: UIViewController {

    var favoriteGameListPresenter: FavoriteGameListPresenterProtocol?

    var favoriteGameList: [RAWGGameDetailModel] = []

    @IBOutlet weak var favoriteGameListTableViewOutlet: UITableView!

    override func viewWillAppear(_ animated: Bool) {

        favoriteGameListPresenter?.willFetchFavoriteGameList()

        if let selectedIndexPath = favoriteGameListTableViewOutlet.indexPathForSelectedRow {
            favoriteGameListTableViewOutlet.deselectRow(at: selectedIndexPath, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorite List"

        favoriteGameListTableViewOutlet.delegate = self
        favoriteGameListTableViewOutlet.dataSource = self

        let nib = UINib(nibName: "GameListCell", bundle: Bundle.main)
        favoriteGameListTableViewOutlet.register(nib, forCellReuseIdentifier: "GameListCell")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hidesBottomBarWhenPushed = false
    }
}

extension FavoriteGameListViewController: FavoriteGameListViewProtocol {
    func showFavoriteList(_ favoriteList: [RAWGGameDetailModel]) {
        self.favoriteGameList = favoriteList
        favoriteGameListTableViewOutlet.reloadData()
    }
}

extension FavoriteGameListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !favoriteGameList.isEmpty else {
            return 0
        }

        return favoriteGameList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: "GameListCell", for: indexPath)

        guard let cell = reusableCell as? GameListCell else { return reusableCell }

        let reusableData = favoriteGameList[indexPath.row]

        cell.selectionStyle = .none
        cell.gameImageViewOutlet.setImageFrom(reusableData.backgroundImage)
        cell.gameNameLabelOutlet.text = reusableData.name
        cell.releaseDataLabelOutlet.text = "Release Date: \(reusableData.released.formattedDate())"
        cell.gameRatingLabelOutlet.text = String(reusableData.rating)

        return cell
    }
}

extension FavoriteGameListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameListCell") as! GameListCell
        return cell.bounds.height
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.hidesBottomBarWhenPushed = true
        let reusableData = favoriteGameList[indexPath.row]
        favoriteGameListPresenter?.willFetchGameDetail(id: reusableData.id)
    }
}
