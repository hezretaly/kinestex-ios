//
//  ImageCache.swift
//  Kinestex
//
//  Created by Hezzi Amanaly on 3/2/22.
//

import Foundation
//import UIKit
import SwiftUI

class ImageCache {
    
    static func storeImage(urlString: String, img: UIImage) {
        let path = NSTemporaryDirectory().appending(UUID().uuidString)
        let url = URL(fileURLWithPath: path)
        
        let data = img.jpegData(compressionQuality: 0.5)
        try? data?.write(to: url)
        
        var dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String:String]
        if dict == nil {
            dict = [String:String]()
        }
        dict![urlString] = path
        UserDefaults.standard.set(dict, forKey: "ImageCache")
    }
    
    static func loadImage(urlString: String, completion:
                          @escaping (String, UIImage?)->Void) {
        
        if let dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String:String] {
            if let path = dict[urlString] {
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                    let img = UIImage(data: data)
                    completion(urlString, img)
                    return
                }
            }
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            guard error == nil else { return }
            guard let d = data else { return }
            DispatchQueue.main.async {
                if let image = UIImage(data: d) {
                    storeImage(urlString: urlString, img: image)
                    completion(urlString, image)
                }
            }
        }
        task.resume()
    }
}
