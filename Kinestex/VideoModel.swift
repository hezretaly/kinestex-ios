//
//  VideoModel.swift
//  Kinestex
//
//  Created by Hezzi Amanaly on 3/4/22.
//

import Foundation
import AVKit

struct VideoDes: Identifiable {
    var id = UUID()
    var title: String = ""
    var description: String = ""
    var videoUrl: String = ""
}

let videoDes = VideoDes(
    title: "Overhead Arms Raise",
    description: "Stand with feet wide in a so-called cactus position. When arms form 90 degrees angles. Extend one arm straight overhead. Repeat the same for another arm.",
    videoUrl: "https://firebasestorage.googleapis.com/v0/b/aiwill-5f38d.appspot.com/o/Jennet%20Arms%20Standing%2FOverhead%20Arms%20Raise.mp4?alt=media&token=8e616fb0-0a0b-428c-ad8d-e4498d5bd71e")


//CacheManager.shared.getFileWith(stringUrl: urlStr) { result in
//
//    switch result {
//    case .success(let url):
//        let videoForFirebase = Video(id: index,countdown: countdownStr, title: titleStr, player: AVQueuePlayer(url: url))
//
//        self.videosFromFirebase.append(videoForFirebase)
//        if self.videosFromFirebase.count > 1{
//            self.loadSwipeView()
//        }
//
//        break;
//    case .failure(let error):
//        // handle errror
//        let videoForFirebase = Video(id: index,countdown: countdownStr, title: titleStr, player: AVQueuePlayer(url: URL(string: urlStr)!))
//
//        self.videosFromFirebase.append(videoForFirebase)
//        //     print(error, " failure in the Cache of video")
//        break;
//    }
//}
