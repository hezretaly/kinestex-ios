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
                .frame(width: 100, height: 100)
                .clipShape(Circle())
//                .shadow(radius: 10)
                .scaledToFill()
//                .cornerRadius(20)
            Text(topCategory.title)
        }
            .onAppear(perform: {
                ImageCache.loadImage(urlString: topCategory.imgURL, completion: setImg)
            })
    }
}

struct NewsTopCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NewsTopCategoryView(topCategory: TopCategory())
    }
}
