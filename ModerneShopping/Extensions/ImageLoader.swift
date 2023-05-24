//
//  ImageLoader.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-01.
//

import SwiftUI
import UIKit

private let _imageCache = NSCache<AnyObject, AnyObject>()

/// Load an image and cache it
class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading = false
    
    var imageCache = _imageCache
    
    func loadImage(with url: URL) {
        let urlString = url.absoluteString
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let session = URLSession.shared
            let task = session.dataTask(with: url) { data, _, error in
                if let error {
                    print("Error: \(error)")
                    return
                }
                    
                guard let data else {
                    print("Failed to get data")
                    return
                }
                    
                DispatchQueue.main.async {
                    guard let image = UIImage(data: data) else {
                        return
                    }
                    self.imageCache.setObject(image, forKey: urlString as AnyObject)
                    DispatchQueue.main.async { [weak self] in
                        self?.image = image
                    }
                }
            }
            task.resume()
        }
    }
}
