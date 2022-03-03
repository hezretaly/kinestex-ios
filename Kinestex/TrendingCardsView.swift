//
//  TrendingCardsView.swift
//  Kinestex
//
//  Created by Hezzi Amanaly on 2/26/22.
//

import SwiftUI


//@ObservedObject var url: LoadUrlImage
//
//init(imageUrl: String) {
//    url = LoadUrlImage(imageURL: imageUrl)
//}
//
//var body: some View {
//    Image(uiImage: UIImage(data: self.url.data) ?? UIImage())
//        .resizable()
//        .scaledToFill()
////        Clipped might be the solution for unscrollable cards
//        .clipped()
//}

struct TrendingCardsView: View {
    
    @State var workout: WorkoutsModel
//    Card images
    @State var img: UIImage = UIImage(imageLiteralResourceName: "HomeTopImage")
    
    func setImg (_ urlImg: String,_ photo: UIImage?) {
        if photo != nil{
            if img.isEqual(photo!) {
                 // Images are the same no reassigning is needed.
                 return
             }
            img = photo!
        }
    }
    
    var body: some View {
        ZStack {
//            TrendingCardView(uiImage: workout.uiImage!)
//                .resizable()
//                .scaledToFill()
//            if #available(iOS 15.0, *) {
//                AsyncImage(url: URL(string: workout.imgURL)) { image in
//                    image.resizable()
//                } placeholder: {
//                    Color.black
//                }
//                .scaledToFill()
//            } else {
//                Image("CategoryImage1")
//                    .resizable()
//                    .scaledToFill()
//                // Fallback on earlier versions
//            }
            Image(uiImage: img)
                .resizable()
                .scaledToFill() 
            HStack {
                VStack(alignment: .leading) {
                    
                    
                    ZStack {
                        Text(workout.sub_category)
                            .padding(EdgeInsets(top: 1, leading: 5, bottom: 1, trailing: 5))
                            .font(.footnote)
                    }
                    .background(Color.green)
                    .cornerRadius(10)
                    
                    Text(workout.title)
                        .font(.body)
                    
                    Text("\(workout.difLevel) - \(workout.totalTime) mins")
                        .font(.footnote)
                    
                    
                }
                //                                    .frame(width: 20, height: 10, alignment: .bottomLeading)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 70, leading: 20, bottom: 0, trailing: 0))
                Spacer()
            }
        }
        .onAppear(perform: {
            ImageCache.loadImage(urlString: workout.imgURL, completion: setImg)
        })
    }
}

struct TrendingCardsView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingCardsView(workout: WorkoutsModel())
    }
}
