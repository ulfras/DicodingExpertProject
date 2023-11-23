//
//  GameListViewController.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 08/11/23.
//

import UIKit

protocol GameListViewProtocol {
    var gameListPresenter: GameListPresenterProtocol? { get set }

    func showGameList(_ gameList: [GameListEntity])

    func failedToFetchGameList(_ errorString: String)

    func showLoadingScreen()

    func dismissLoadingScreen()
}

class GameListViewController: UIViewController {

    var gameListPresenter: GameListPresenterProtocol?

    var gameListData: [GameListEntity] = []

    @IBOutlet weak var gameListTableViewOutlet: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gameListPresenter?.willFetchGameList()

        if let selectedIndexPath = gameListTableViewOutlet.indexPathForSelectedRow {
            gameListTableViewOutlet.deselectRow(at: selectedIndexPath, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Game List"

        gameListTableViewOutlet.delegate = self
        gameListTableViewOutlet.dataSource = self

        gameListTableViewOutlet.register(UINib(nibName: "GameListCell", bundle: Bundle.main), forCellReuseIdentifier: "GameListCell")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hidesBottomBarWhenPushed = false
    }
}

extension GameListViewController: GameListViewProtocol {

    func showLoadingScreen() {
        let loadingVC = LoadingScreenViewController()
        loadingVC.modalPresentationStyle = .overCurrentContext

        // Animate loadingVC with a fade in animation
        loadingVC.modalTransitionStyle = .crossDissolve
        self.present(loadingVC, animated: true)
    }

    func dismissLoadingScreen() {
        self.dismiss(animated: true)
    }

    func showGameList(_ gameList: [GameListEntity]) {
        self.gameListData = gameList
        gameListTableViewOutlet.reloadData()
    }

    func failedToFetchGameList(_ errorString: String) {
        let alert = UIAlertController(title: "Error", message: "Failed to fetch game list: \(errorString)", preferredStyle: .alert)

        let retryButton = UIAlertAction(title: "Retry", style: .default) { _ in
            self.gameListPresenter?.willFetchGameList()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)

        alert.addAction(cancelButton)
        alert.addAction(retryButton)

        self.present(alert, animated: true)
    }
}

extension GameListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard !gameListData.isEmpty else {
            return 0
        }

        return gameListData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: "GameListCell", for: indexPath)

        guard let cell = reusableCell as? GameListCell else { return reusableCell }

        let reusableData = gameListData[indexPath.row]

        cell.selectionStyle = .none
        cell.gameImageViewOutlet.setImageFrom(reusableData.backgroundImage)
        cell.gameNameLabelOutlet.text = reusableData.name
        cell.releaseDataLabelOutlet.text = "Release Date: \(reusableData.released.formattedDate())"
        cell.gameRatingLabelOutlet.text = String(reusableData.rating)

        return cell
    }
}

extension GameListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameListCell") as! GameListCell
        return cell.bounds.height
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.hidesBottomBarWhenPushed = true
        let reusableData = gameListData[indexPath.row]
        gameListPresenter?.willFetchGameDetail(id: reusableData.id)
    }
}
