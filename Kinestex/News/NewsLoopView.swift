//
//  NewsLoopView.swift
//  Kinestex
//
//  Created by Hezzi Amanaly on 3/3/22.
//

import SwiftUI

struct NewsLoopView: View {
    
    @State var newsLoop: NewsLoop
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
        ZStack {
            Image(uiImage: img)
                .resizable()
                .frame(width: 300, height: 200)
                .scaledToFill()
                .clipped()
            HStack {
                VStack(alignment: .leading) {
                    Spacer()

                    Text(newsLoop.title)
                        .font(.title)
                    
                    Text(newsLoop.author)
                        .font(.body)
                    
                }
//                .foregroundColor(.white)
//                .padding(EdgeInsets(top: 70, leading: 20, bottom: 0, trailing: 0))
                Spacer()
            }
        }
        .onAppear(perform: {
            ImageCache.loadImage(urlString: newsLoop.imgURL, completion: setImg)
        })
    }
}

struct NewsLoopView_Previews: PreviewProvider {
    static var previews: some View {
        NewsLoopView(newsLoop: NewsLoop())
    }
}
