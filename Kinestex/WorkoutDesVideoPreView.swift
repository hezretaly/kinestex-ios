//
//  WorkoutDesVideoPreView.swift
//  Kinestex
//
//  Created by Hezzi Amanaly on 3/3/22.
//

import SwiftUI
import AVKit

struct WorkoutDesVideoPreView: View {
    
    @State var vd: VideoDes
    @State var vUrl: URL?
        
    var body: some View {
        VStack {
            if vUrl != nil {
                PlayerView(url: vUrl!)
            } else {
                PlayerView(url: URL(string: vd.videoUrl)!)
            }
//                        .aspectRatio(contentMode: .fill)
//                        .frame(height: 550)
            //            .overlay(Color.black.opacity(0.2))
            //            .blur(radius: 1)
            //            .edgesIgnoringSafeArea(.all)
            //        This shows but nsData doesn't, hmm
            //        VideoPlayer(player: AVPlayer(url:  URL(string: "https://bit.ly/swswift")!))
            //            .frame(height: 400)
            
//            VideoPlayer(player: vd.avqueplayer)
                    
                    VStack(spacing: 10) {
                        Text(vd.title)
                            .font(.title)
                        
                        Text(vd.description)
                    }
                    .padding()
                    

                    Spacer()
        }
        .onAppear(perform: {
            CacheManager.shared.getFileWith(stringUrl: vd.videoUrl) { result in
                switch result {
                   case .success(let url):
//                        self.vd.avqueplayer = url
                        self.vUrl = url
               
//                       self.videosFromFirebase.append(videoForFirebase)
//                       if self.videosFromFirebase.count > 1{
//                           self.loadSwipeView()
//                       }
               
                       break;
                   case .failure(let error):
                       // handle errror
//                       let videoForFirebase = Video(id: index,countdown: countdownStr, title: titleStr, player: AVQueuePlayer(url: URL(string: urlStr)!))
//
//                       self.videosFromFirebase.append(videoForFirebase)
                            print(error, " failure in the Cache of video")
                       break;
                   }
            }
        })

    }
}

struct WorkoutDesVideoPreView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDesVideoPreView(vd: videoDes)
    }
}
