//
//  NewsRecView.swift
//  Kinestex
//
//  Created by Hezzi Amanaly on 3/4/22.
//

import SwiftUI

struct NewsRecView: View {
    
    @State var newsRec: NewsRec
    @State var img: UIImage = UIImage(imageLiteralResourceName: "HomeTopImage")
    @State private var isPresented: Bool = false
    
    func setImg (_ urlImg: String,_ photo: UIImage?) {
        if photo != nil{
            if img.isEqual(photo!) {
                 return
             }
            img = photo!
        }
    }
    
    var body: some View {
                HStack {
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                    
                    VStack {
                        Text(newsRec.title)
                            .font(.title)
                        
                        Text(newsRec.category)
                    }
                    
                    Spacer()
                }
//                        .padding(.leading, 10)
                .onTapGesture {
                    isPresented.toggle()
                }
                .sheet(isPresented: $isPresented) {
                    SheetView()
                }
        .padding(.leading, 20)
        .onAppear(perform: {
            ImageCache.loadImage(urlString: newsRec.imgURL, completion: setImg)
        })
    }
}

struct NewsRecView_Previews: PreviewProvider {
    static var previews: some View {
        NewsRecView(newsRec: NewsRec())
    }
}
