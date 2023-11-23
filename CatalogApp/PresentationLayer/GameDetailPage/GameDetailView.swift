//
//  GameDetailView.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 08/11/23.
//

import UIKit

protocol GameDetailViewProtocol {
    var gameDetailPresenter: GameDetailPresenterProtocol? { get set }

    func showGameDetailData(gameDetailData: RAWGGameDetailModel)

    func failedToFetchGameDetail(_ errorString: String)
}

class GameDetailViewController: UIViewController {

    var gameDetailPresenter: GameDetailPresenterProtocol?
    var gameDetailData: RAWGGameDetailModel?

    @IBOutlet weak var gameImageViewOutlet: UIImageView!
    @IBOutlet weak var developerNameLabelOutlet: UILabel!
    @IBOutlet weak var publisherNameLabelOutlet: UILabel!
    @IBOutlet weak var releaseDateLabelOutlet: UILabel!
    @IBOutlet weak var ratingLabelOutlet: UILabel!
    @IBOutlet weak var gameDescTextViewOutlet: UITextView!
    @IBOutlet weak var visitWebsiteButtonOutlet: UIButton!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gameDetailPresenter?.willFetchGameDetail()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        gameImageViewOutlet.layer.cornerRadius = 15
        gameImageViewOutlet.layer.borderWidth = 1
        gameImageViewOutlet.layer.borderColor = UIColor.black.cgColor

        visitWebsiteButtonOutlet.layer.cornerRadius = 10
        visitWebsiteButtonOutlet.layer.borderWidth = 1
        visitWebsiteButtonOutlet.layer.borderColor = UIColor.systemBlue.cgColor
    }

    private func updateFavoriteButton(_ isFavorited: Bool) {
        let favoriteImageName = isFavorited ? "heart.fill" : "heart"
        let favoriteImage = UIImage(systemName: favoriteImageName)

        let favoriteButton = UIBarButtonItem(image: favoriteImage, landscapeImagePhone: favoriteImage, style: .done, target: self, action: #selector(favoriteButtonTapped))
        favoriteButton.tintColor = .systemBlue

        navigationItem.rightBarButtonItem = favoriteButton
    }

    @objc func favoriteButtonTapped() {
        guard var gameDetailData = gameDetailData else { return }

        if gameDetailData.isFavorite == nil || gameDetailData.isFavorite! == false {
            gameDetailData.isFavorite = true
            self.gameDetailData = gameDetailData
            updateFavoriteButton(gameDetailData.isFavorite!)
            gameDetailPresenter?.willAddToFavorite(gameDetailData)
        } else {
            gameDetailData.isFavorite?.toggle()
            self.gameDetailData = gameDetailData
            updateFavoriteButton(gameDetailData.isFavorite!)
            gameDetailPresenter?.willRemoveFromFavorite(gameDetailData.id)
        }
    }

    @IBAction func visitGameWebTapIn(_ sender: Any) {

        guard let gameDetailData = gameDetailData else { return }

        if gameDetailData.website == "" {
            CustomToast.show(message: "No Website Provided", bgColor: .systemRed, controller: self)
        } else {
            gameDetailPresenter?.willGoToGameWebsite(gameDetailData.website)
        }
    }
}

extension GameDetailViewController: GameDetailViewProtocol {
    func failedToFetchGameDetail(_ errorString: String) {
        let alert = UIAlertController(title: "Error", message: "Failed to fetch game detail: \(errorString)", preferredStyle: .alert)

        let retryButton = UIAlertAction(title: "Retry", style: .default) { _ in
            self.gameDetailPresenter?.willFetchGameDetail()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)

        alert.addAction(retryButton)
        alert.addAction(cancelButton)

        self.present(alert, animated: true)
    }

    func showGameDetailData(gameDetailData: RAWGGameDetailModel) {

        self.gameDetailData = gameDetailData

        if gameDetailData.isFavorite != nil {
            updateFavoriteButton(gameDetailData.isFavorite!)
        } else {
            updateFavoriteButton(false)
        }

        gameImageViewOutlet.setImageFrom(gameDetailData.backgroundImage)

        let gameDev = gameDetailData.developers.map { $0.name }.joined(separator: ", ")
        developerNameLabelOutlet.text = "Developer: \(gameDev)"

        let gamePub = gameDetailData.publishers.map { $0.name }.joined(separator: ", ")
        publisherNameLabelOutlet.text = "Publisher: \(gamePub)"

        releaseDateLabelOutlet.text = "Release Date: \(gameDetailData.released.formattedDate())"
        ratingLabelOutlet.text = "Game Rating: \(gameDetailData.esrbRating.name)"
        gameDescTextViewOutlet.text = gameDetailData.descriptionRaw

    }
}
