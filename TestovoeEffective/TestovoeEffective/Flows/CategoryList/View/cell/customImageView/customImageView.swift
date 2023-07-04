//
//  customImageView.swift
//  TestovoeEffective
//
//  Created by Oleg on 29.06.2023.
//

import Foundation
import UIKit

final class ImageCache {
    static let shared = ImageCache()
    private let cacheDirectory: URL
    
    private init() {
        let fileManager = FileManager.default
        guard let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else { fatalError("Unable to access cache directory") }
        self.cacheDirectory = cacheDirectory
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        
        let fileName = (key as NSString).lastPathComponent
        let fileURL = cacheDirectory.appendingPathComponent(fileName)
        let imageData = image.pngData()
        do {
            try imageData?.write(to: fileURL)
        } catch {
            print("Ошибка при сохранении изображения:", error)
        }
    }
    
    func getImage(forKey key: String) -> UIImage? {
        let fileName = (key as NSString).lastPathComponent
        let fileURL = cacheDirectory.appendingPathExtension(fileName)
        guard let imageData = try? Data(contentsOf: fileURL) else {
            return nil
        }
        print("take")
        return UIImage(data: imageData)
    }
}

class CustomImageView: UIImageView {
    let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    func load(urlString: String, key: Int) {
        guard let url = URL(string: urlString) else { return }
        
        image = nil
        
        addSpinner()
        
        if let imageFromCache = ImageCache.shared.getImage(forKey: String(key)) {
            image = imageFromCache
            stopSpinner()
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let data = data {
                    if let rI = UIImage(data: data) {
                        ImageCache.shared.setImage(rI, forKey: String(key))
                        self.image = rI
                        self.stopSpinner()
                    }
                }
            }
        }
        task.resume()
    }
    
    func addSpinner() {
        addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.startAnimating()
    }
    
    func stopSpinner() {
        spinner.stopAnimating()
    }
}
