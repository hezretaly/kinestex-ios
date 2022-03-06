//
//  NewsLoopDetailView.swift
//  Kinestex
//
//  Created by Hezzi Amanaly on 3/6/22.
//

import SwiftUI

struct NewsLoopDetailView: View {
    var loopN: NewsLoop
    
    @State var img: UIImage = UIImage(imageLiteralResourceName: "HomeTopImage")
    
    func setImg (_ urlImg: String,_ photo: UIImage?) {
        if photo != nil{
            if img.isEqual(photo!) {
                 return
             }
            img = photo!
        }
    }
    
    var body: some View {
        ScrollView {
        VStack {
            Image(uiImage:  img)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
            
            Text(loopN.title)
                .font(.title)
            
            Text(loopN.text)
                .padding()
        }
        }
        .onAppear(perform: {
            ImageCache.loadImage(urlString: loopN.imgURL, completion: setImg)
        })
        
//            .onTapGesture {
//                self.index = workout.videosDes.firstIndex(where: {$0.id==video.id})!
////                            self.isPresented.toggle()
//            }
    }
}

struct NewsLoopDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NewsLoopDetailView(loopN: NewsLoop())
    }
}
