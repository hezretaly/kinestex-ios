//
//  ContentView.swift
//  Kinestex
//
//  Created by Hezzi Amanaly on 2/19/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {

        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("home")
                }
            Text("This would be second view")
                .tabItem {
                    Image(systemName: "figure.walk")
                    Text("moves")
                }
            ArticlesView()
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("news")
                }
            UserProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("profile")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
