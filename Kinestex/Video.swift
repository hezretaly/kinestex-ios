//
//  Video.swift
//  Kinestex
//
//  Created by Hezzi Amanaly on 3/3/22.
//

import Foundation
import SwiftUI
import AVKit


struct PlayerView: UIViewRepresentable {
    var url: URL
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
    }

    func makeUIView(context: Context) -> UIView {
//        return LoopingPlayerUIView(frame: CGRect.zero)
        return LoopingPlayerUIView(url: url)
    }
}

//let homeController: HomeController
//
//   required init(controller: HomeController){
//       homeController = controller
//       super.init(frame: CGRect.zero)
//       // Can't call super.init() here because it's a convenience initializer not a desginated initializer
//   }
//
//   required init?(coder aDecoder: NSCoder) {
//       fatalError("init(coder:) has not been implemented")
//   }


class LoopingPlayerUIView: UIView {
    var url: URL
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    required init(url: URL){
        self.url = url
        super.init(frame: CGRect.zero)
    }
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
    override func layoutSubviews() {
        super.layoutSubviews()
        // Load the resource -> h
        let fileUrl = url
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)
        // Setup the player
        let player = AVQueuePlayer()
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        // Create a new player looper with the queue player and template item
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        // Start the movie
        player.play()
        playerLayer.frame = bounds
    }
}


//struct someView: View {
//    var body: some View {
//
//        GeometryReader{ geo in
//            ZStack {
//                PlayerView()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: geo.size.width, height: geo.size.height+100)
//                    .overlay(Color.black.opacity(0.2))
//                    .blur(radius: 1)
//                    .edgesIgnoringSafeArea(.all)
//
//                VStack{
//                    Text("Hello World")
//                        .font(.title)
//                        .foregroundColor(.white)
//                    Spacer()
//                }
//            }
//        }
//
//    }
//}
