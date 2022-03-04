//
//  ArticlesView.swift
//  Kinestex
//
//  Created by Hezzi Amanaly on 3/3/22.
//

import SwiftUI

struct ArticlesView: View {
    
    @StateObject private var firebaseManager = FirebaseManager()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(firebaseManager.news.topCategory){ topCategory in
                                NewsTopCategoryView(topCategory: topCategory)
                            }
                        }
                    }
                    
                    Divider()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(firebaseManager.news.newsLoop){ newsLoop in
                                NewsLoopView(newsLoop: newsLoop)
                            }
                        }
                    }
                    
                    Divider()
                    
                    VStack{
                        ForEach(firebaseManager.news.newsRec){ newsRec in
                            NewsRecView(newsRec: newsRec)
                        }
                    }
                    
                    
                    
                    
                }
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
