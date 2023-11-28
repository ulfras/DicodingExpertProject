//
//  UIImageView + Extension.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 09/11/23.
//

import UIKit

extension UIImageView {

    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
        self.addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        let centerX = NSLayoutConstraint(item: self,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        let centerY = NSLayoutConstraint(item: self,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)
        self.addConstraints([centerX, centerY])
        return activityIndicator
    }

    func setImageFrom(_ urlString: String, completion: (() -> Void)? = nil) async {
        guard let imageURL = URL(string: urlString) else { return }

        if let cachedImage = ImageCache.shared.image(forKey: urlString) {
            self.image = cachedImage
            completion?()
            return
        }

        let activityIndicator = createActivityIndicator()
        activityIndicator.startAnimating()

        do {
            let imageData = try await URLSession.shared.data(from: imageURL).0

            if let image = UIImage(data: imageData) {
                let resizedImage = image.resized(toWidth: 500)
                ImageCache.shared.saveImage(resizedImage, forKey: urlString)

                self.image = resizedImage
                completion?()
            } else {
                print("Failed to create image from data")
            }
        } catch {
            print("Failed to download image: \(error)")
        }

        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}
