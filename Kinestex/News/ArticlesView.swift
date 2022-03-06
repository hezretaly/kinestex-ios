//
//  ArticlesView.swift
//  Kinestex
//
//  Created by Hezzi Amanaly on 3/3/22.
//

import SwiftUI

struct ArticlesView: View {
    
    @StateObject private var firebaseManager = FirebaseManager()
    @State private var categ = "All News"
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
            ScrollView {
                
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(firebaseManager.news.topCategory){ topCategory in
                                    NewsTopCategoryView(topCategory: topCategory, categ: $categ)
                                }
                            }
                        }
                        
                        Divider()
                        
//                        ScrollView(.horizontal, showsIndicators: false) {
                        NewsLoopTestView(newsLoops: firebaseManager.news.newsLoop, proxy: proxy)
    //                        HStack(spacing: 10) {
    //                            ForEach(firebaseManager.news.newsLoop){ newsLoop in
    //                                NewsLoopView(newsLoop: newsLoop)
    //                            }
    //                        }
//                        }
                        
                        Divider()
                        
                        VStack(spacing: 10){
                           
                            ForEach(firebaseManager.news.newsRec){ newsRec in
                               switch categ {
                               case "All News":
                                    NewsRecView(newsRec: newsRec)
                               case "Brain":
                                   if newsRec.category.contains("Brain"){
                                       NewsRecView(newsRec: newsRec)
                                   }
                               case "Diet":
                                   if newsRec.category.contains("Diet"){
                                       NewsRecView(newsRec: newsRec)
                                   }
                               case "Fitness":
                                   if newsRec.category.contains("Fitness"){
                                       NewsRecView(newsRec: newsRec)
                                   }
                               case "Yoga":
                                   if newsRec.category.contains("Yoga"){
                                       NewsRecView(newsRec: newsRec)
                                   }
                               default:
                                   NewsRecView(newsRec: newsRec)
                               }
                                
                            }
                        }
                        
                        
                        
                        
                    }
                }
                .navigationTitle("Articles")
            }
            
        }
        .onAppear(perform: {
            firebaseManager.articlesGet()
        })
        
    }
}

struct ArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesView()
    }
}
