//
//  ImageService.swift
//  myFit
//
//  Created by Winston Maragh on 9/7/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit


class ImageService {
    private init() {}
    static let shared = ImageService()
    
    func getImage(from urlStr: String,
                  completionHandler: @escaping (UIImage?) -> Void) {
        
        if let cacheImage = ImageCacheService.shared.getImageFromCache(string: urlStr) {
            completionHandler(cacheImage)
            return
        }
        
        DispatchQueue.global().async {
            guard let url = URL(string: urlStr) else {print("Bad URL used in ImageService"); return }
            guard let data = try? Data(contentsOf: url) else {return}
            guard let image = UIImage(data: data) else {return}
            ImageCacheService.shared.saveImageToCache(with: urlStr, image: image)
            completionHandler(image)
        }
    }
}


class ImageCacheService {
    private init(){}
    static let shared = ImageCacheService()
    
    private var imageCache = NSCache<NSString, UIImage>()
    
    func getImageFromCache(string: String) -> UIImage? {
        return imageCache.object(forKey: string as NSString)
    }
    
    func saveImageToCache(with urlStr: String, image: UIImage) {
        self.imageCache.setObject(image, forKey: urlStr as NSString)
    }
    
}


extension UIImageView {
    
    func loadImage(imageURLString: String) {
        let spinner: UIActivityIndicatorView = {
            let sp = UIActivityIndicatorView()
            sp.activityIndicatorViewStyle = .white
            return sp
        }()
        
        self.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        
        spinner.startAnimating()
        spinner.isHidden = false
        
        ImageService.shared.getImage(from: imageURLString) { (image) in
            DispatchQueue.main.async {
                self.image = nil
                self.image = image
                spinner.stopAnimating()
                spinner.isHidden = true
            }
        }
    }
    
}

