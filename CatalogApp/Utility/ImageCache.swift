//
//  ImageCache.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 09/11/23.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()

    private var cache = NSCache<NSString, UIImage>()

    func image(forKey imageCacheKey: String) -> UIImage? {
        return cache.object(forKey: imageCacheKey as NSString)
    }

    func saveImage(_ image: UIImage, forKey imageCacheKey: String) {
        cache.setObject(image, forKey: imageCacheKey as NSString)
    }
}
