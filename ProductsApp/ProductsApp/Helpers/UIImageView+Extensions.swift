//
//  UIImageView+Extensions.swift
//  ProductsApp
//
//  Created by Jefin on 21/05/22.
//

import UIKit

extension UIImageView {
    func loadImage(imageUrl: String) {
        let cache = NSCache<NSString, UIImage>()
        let cacheItem = imageUrl as NSString
        if let cachedImage = cache.object(forKey: cacheItem) {
            print("Using a cached image for item: \(cacheItem)")
            DispatchQueue.main.async {
                self.image = cachedImage
            }
        } else {
            guard let Url = URL(string: imageUrl) else { preconditionFailure("failed to fetch the url") }
            
            let request = URLRequest(url: Url)
            URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
                if let data = data {
                    guard let image = UIImage(data: data) else { return }
                    cache.setObject(image, forKey: cacheItem)
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }).resume()
        }
    }
}
