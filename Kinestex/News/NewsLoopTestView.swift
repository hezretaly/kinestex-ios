//
//  NewsLoopTestView.swift
//  Kinestex
//
//  Created by Hezzi Amanaly on 3/6/22.
//

import SwiftUI

struct NewsLoopTestView: View {
    
    var newsLoops: [NewsLoop]
    var proxy: GeometryProxy
    
    var noi = 5
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var currentInex = 0
    var body: some View {
//        GeometryReader { proxy in
            if newsLoops.count > 0 {
                TabView(selection: $currentInex) {
                    ForEach(newsLoops.indices){ index in
                        NewsLoopView(newsLoop: newsLoops[index], cardWidth: proxy.size.width)
    //                    Image("HomeTopImage")
    //                        .resizable()
    //                        .scaledToFill()
                            .tag(index)
                            
                    }
                }.tabViewStyle(PageTabViewStyle())
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding()
                    .frame(width: proxy.size.width, height: proxy.size.height/2.5)
                    .shadow(radius: 10)
                    .onReceive(timer, perform: {_ in
                        withAnimation {
                            currentInex = currentInex < newsLoops.count ? currentInex + 1 : 0
                        }
                    })
            } else {
                TabView(selection: $currentInex) {
                    ForEach(0..<noi){ i in
                        Image("HomeTopImage")
                            .resizable()
                            .scaledToFill()
                            .tag(i)
                    }
                }.tabViewStyle(PageTabViewStyle())
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding()
//                    .frame(width: 300  , height:200)
                    .frame(width: proxy.size.width, height: proxy.size.height/3)
                    .onReceive(timer, perform: {_ in
                        withAnimation {
                            currentInex = currentInex < newsLoops.count ? currentInex + 1 : 0
                        }
                    })
            }
            
//        }
    }
}

struct NewsLoopTestView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { proxy in
            NewsLoopTestView(newsLoops: [NewsLoop()], proxy: proxy)
        }
    }
}
