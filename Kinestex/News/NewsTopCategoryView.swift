//
//  NewsTopCategoryView.swift
//  Kinestex
//
//  Created by Hezzi Amanaly on 3/3/22.
//

import SwiftUI

struct NewsTopCategoryView: View {
    
    @State var topCategory: TopCategory
    @State var img: UIImage = UIImage(imageLiteralResourceName: "HomeTopImage")
    
    @Binding var categ: String
    
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
//            if topCategory.title == categ {
//                Image(uiImage: img)
//                    .frame(width: 100, height: 100)
//                    .border(Color.red, width: 5)
//                    .clipShape(Circle())
//    //                .shadow(radius: 10)
//                    .scaledToFill()
//
//            }else{
//            Image(uiImage: img)
//                .frame(width: 100, height: 100)
//                .clipShape(Circle())
////                .shadow(radius: 10)
//                .scaledToFill()
////                .cornerRadius(20)
//
//            }
            Button {
                categ = topCategory.title
            } label: {
                if categ == topCategory.title {
                Image(uiImage: img)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .scaledToFill()
                    .overlay(Circle().stroke(Color.red, lineWidth: 2))
                } else {
                    Image(uiImage: img)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .scaledToFill()
                }
            }
            Text(topCategory.title)
        }
        .padding(.top)
            .onAppear(perform: {
                ImageCache.loadImage(urlString: topCategory.imgURL, completion: setImg)
            })
    }
}

struct NewsTopCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NewsTopCategoryView(topCategory: TopCategory(), categ: .constant("hello"))
    }
}
