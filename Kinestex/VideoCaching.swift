//
//  VideoCaching.swift
//  Kinestex
//
//  Created by Hezzi Amanaly on 3/3/22.
//

import Foundation
import AVFoundation


class VideoCaching {
    
    static func storeVideo(urlString: String, vid: NSData) {
        let path = NSTemporaryDirectory().appending(UUID().uuidString)
        let url = URL(fileURLWithPath: path)
        
        let data = vid
        data.write(to: url, atomically: true)
        print("vid has been saved")
        
        var dict = UserDefaults.standard.object(forKey: "VideoCache") as? [String:String]
        if dict == nil {
            dict = [String:String]()
        }
        dict![urlString] = path
        UserDefaults.standard.set(dict, forKey: "VideoCache")
    }
    
    static func loadImage(urlString: String, completion:
                          @escaping (Bool)->Void) {
        
        if let dict = UserDefaults.standard.object(forKey: "VideoCache") as? [String:String] {
            if let path = dict[urlString] {
                if NSData(contentsOf: URL(fileURLWithPath: path)) != nil {
//                    let videoData = NSData(contentsOf: URL(string: urlString)!)
                    print("now it should get here")
                    completion(true)
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
                print("ey so here")
                if let videoData = NSData(data: d) as? NSData {
                    storeVideo(urlString: urlString, vid: videoData)
                    completion(true)
                }
            }
        }
        task.resume()
    }
}


//
//public enum Result<T> {
//    case success(T)
//    case failure(NSError)
//}
//
//class VideoCaching {
//
//    static let shared = VideoCaching()
//    private let fileManager = FileManager.default
//    private lazy var mainDirectoryUrl: URL = {
//        let documentsUrl = self.fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
//        return documentsUrl
//    }()
//
//    func getFileWith(stringUrl: String, completionHandler: @escaping (Result<URL>) -> Void ) {
//
//        let file = directoryFor(stringUrl: stringUrl)
//
//        //return file path if already exists in cache directory
//        guard !fileManager.fileExists(atPath: file.path)  else {
//            completionHandler(Result.success(file))
//            return
//        }
//
//        DispatchQueue.global().async {
//
//            if let videoData = NSData(contentsOf: URL(string: stringUrl)!) {
//                videoData.write(to: file, atomically: true)
//                DispatchQueue.main.async {
//                    completionHandler(Result.success(file))
//                }
//            } else {
//                DispatchQueue.main.async {
//                    let error = NSError(domain: "SomeErrorDomain", code: -2001 /* some error code */, userInfo: ["description": "Can't download video"])
//
//                    completionHandler(Result.failure(error))
//                }
//            }
//        }
//    }
//
//    private func directoryFor(stringUrl: String) -> URL {
//
//        let fileURL = URL(string: stringUrl)!.lastPathComponent
//        let file = self.mainDirectoryUrl.appendingPathComponent(fileURL)
//        return file
//    }
//}


//And where it's being used

//func fetchDataFirebase()->Void{
//        database.child("workouts").child("Arms & Shoulders").child("exercises").observe(DataEventType.value, with: {(snapshot) in
//            if snapshot.childrenCount > 0{
//                self.videosFromFirebase.removeAll()
//                let index = 0
//                for video in snapshot.children.allObjects as! [DataSnapshot]{
//                    let Object = video.value as? [String: AnyObject]
//                    let tv = Object?["tv"]
//                    let videoURL = Object?["videoURL"]
//                    let countdown = Object?["countdown"]
//
//                    let urlStr = videoURL as! String
//                    CacheManager.shared.getFileWith(stringUrl: urlStr) { result in
//
//                        switch result {
//                        case .success(let url):
//                            let videoForFirebase = Video(id: index, player: AVQueuePlayer(url: url))
//
//                            self.videosFromFirebase.append(videoForFirebase)
//                            if self.videosFromFirebase.count > 1{
//                                self.loadSwipeView()
//                            }
//
//                            break;
//                        case .failure(let error):
//                            // handle errror
//                            let videoForFirebase = Video(id: index, player: AVQueuePlayer(url: URL(string: urlStr)!))
//
//                            self.videosFromFirebase.append(videoForFirebase)
//                            print(error, " failure in the Cache of video")
//                            break;
//                        }
//                    }
//
//
//
//
//                }
//
//
//            }
//        })
