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
    @State private var isPresented: Bool = false
    var cardWidth = 0.0
    
    func setImg (_ urlImg: String,_ photo: UIImage?) {
        if photo != nil{
            if img.isEqual(photo!) {
                 return
             }
            img = photo!
        }
    }
    
    var body: some View {
        VStack {
            Image(uiImage: img)
                .resizable()
                .scaledToFill()
                .frame(width: cardWidth, height: 200)
//                .overlay(Color(UIColor.systemBackground).opacity(0.4))
//                .cornerRadius(5)
                .clipped()
            
                VStack {
                        Text(newsLoop.title)
                            .font(.title2)
                            .lineLimit(1)
                            .padding(.bottom)
                            .padding(.bottom)
                            
                        
//                        Text(newsLoop.author)
//                            .font(.body)
//                            .padding(.bottom)
//                            .frame(width: cardWidth)
//                            .background(Color(UIColor.systemBackground).opacity(0.8))
                    
//                    .padding()
//                    .frame(width: cardWidth)
//                        .background(Color(UIColor.systemBackground).opacity(0.8))
                
//                .foregroundColor(.white)
//                .padding(EdgeInsets(top: 70, leading: 20, bottom: 0, trailing: 0))
//                Spacer()
            }
//                .frame(height: 50)
            
        }
        .onTapGesture {
            isPresented.toggle()
        }
        .sheet(isPresented: $isPresented) {
//            SheetView()
            NewsLoopDetailView(loopN: newsLoop)
        }
//        .frame(width: 350, height: 250)
        .onAppear(perform: {
            ImageCache.loadImage(urlString: newsLoop.imgURL, completion: setImg)
        })
    }
}

struct NewsLoopView_Previews: PreviewProvider {
    static var previews: some View {
        NewsLoopView(newsLoop: NewsLoop(), cardWidth: 0.0)
    }
}
