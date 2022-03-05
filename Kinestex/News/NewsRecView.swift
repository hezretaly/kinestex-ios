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
        ZStack {
            Image(uiImage: img)
                .resizable()
                .frame(width: 350, height: 200)
                .scaledToFill()
                .clipped()
            HStack {
                VStack(alignment: .leading) {
                    ZStack {
                        Text(newsRec.category)
                            .padding(EdgeInsets(top: 1, leading: 5, bottom: 1, trailing: 5))
                            .font(.footnote)
                    }
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding()
                    Spacer()
                }
                Spacer()
            }
            
//            Spacer()

            VStack {
                Spacer()
                VStack {
                    Text(newsRec.title)
                        .font(.title3)

                    Text(newsRec.author)
                }
                .frame(width: 350, height: 50)
                .background(Color(UIColor.systemBackground).opacity(0.8))
            }

            
        }
        .frame(width: 350, height: 200)
        .cornerRadius(10)
//        ZStack {
//            Image(uiImage: img)
//                .resizable()
//                .scaledToFill()
//                .clipped()
//
//            HStack {
//                VStack(alignment: .leading) {
//
//                    Text(newsRec.title)
//                        .font(.title)
//
//                    Text(newsRec.category)
//                        .font(.body)
//
//                }
//                //                                    .frame(width: 20, height: 10, alignment: .bottomLeading)
//                .foregroundColor(.white)
//                .padding(EdgeInsets(top: 70, leading: 20, bottom: 0, trailing: 0))
//
//                Spacer()
//            }
//        }
//        .frame(width: 350, height: 150)
        //                        .padding(.leading, 10)
        .onTapGesture {
            isPresented.toggle()
        }
        .sheet(isPresented: $isPresented) {
            SheetView()
        }
        .padding()
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
