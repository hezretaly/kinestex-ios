//
//  NewsRecDetailView.swift
//  Kinestex
//
//  Created by Hezzi Amanaly on 3/6/22.
//

import SwiftUI

struct NewsRecDetailView: View {
    
    var recN: NewsRec
    
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
            
            Text(recN.title)
                .font(.title)
            
            Text(recN.text)
                .padding()
        }
        }
        .onAppear(perform: {
            ImageCache.loadImage(urlString: recN.imgURL, completion: setImg)
        })
        
//            .onTapGesture {
//                self.index = workout.videosDes.firstIndex(where: {$0.id==video.id})!
////                            self.isPresented.toggle()
//            }
    }
}

struct NewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NewsRecDetailView(recN: NewsRec())
    }
}
