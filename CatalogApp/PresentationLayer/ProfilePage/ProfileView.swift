//
//  ProfileView.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 08/11/23.
//

import UIKit

protocol ProfileViewProtocol {
    var profilePresenter: ProfilePresenterProtocol? { get set }

    func showDeveloperName(_ devName: String)
}

class ProfileViewController: UIViewController {

    var profilePresenter: ProfilePresenterProtocol?

    @IBOutlet weak var devImageViewOutlet: UIImageView!
    @IBOutlet weak var devNameLabelOutlet: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        profilePresenter?.willCheckDeveloperName()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Profile"
        setupUI()
    }

    private func setupUI () {
        let editProfileImage = UIImage(systemName: "square.and.pencil")

        let editProfileButton = UIBarButtonItem(image: editProfileImage, style: .plain, target: self, action: #selector(editProfile))
        navigationItem.rightBarButtonItem = editProfileButton

        devImageViewOutlet.layer.cornerRadius = devImageViewOutlet.frame.size.width / 2
        devImageViewOutlet.layer.borderWidth = 1
        devImageViewOutlet.layer.borderColor = UIColor.dicoding.cgColor
    }

    @objc func editProfile() {
        let alert = UIAlertController(title: "Change Name", message: "Want to change the name?", preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = "Enter new name"
            textField.textAlignment = .center
            textField.keyboardType = .default
        }

        let okButton = UIAlertAction(title: "OK", style: .default) { _ in
            if let devName = alert.textFields?.first?.text {
                if devName == "" {
                    self.present(alert, animated: true)
                } else {
                    self.profilePresenter?.willSaveDeveloperName(devName)
                }
            }
        }

        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)

        alert.addAction(cancelButton)
        alert.addAction(okButton)

        self.present(alert, animated: true)
    }
}

extension ProfileViewController: ProfileViewProtocol {
    func showDeveloperName(_ devName: String) {
        devNameLabelOutlet.text = devName
    }
}
