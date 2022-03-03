//
//  HomeView.swift
//  Kinestex
//
//  Created by Hezzi Amanaly on 2/26/22.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var firebaseManager = FirebaseManager()
    
//    We need environmentObjectt for getting environment object rather than creating one every time
//    @EnvironmentObject var modelData: ModelData
//    @State var workout = firebaseManager.workouts
//    @State public var workouts: [WorkoutsModel] = []
    
    
    var body: some View {
        NavigationView {
            VStack {
                //                Can't have more than 10 sub elements
                ScrollView {
                    //                ZStack {
                    //
                    //                }
                    ////                    .font(.system(size: 250))
                    //                    .frame(width: 300, height: 200)
                    //                    .background(Color.yellow)
                    //                    .cornerRadius(10)
                    //                    .padding(.bottom)
                    
                    ZStack {
                        //            Color.blue.ignoresSafeArea()
                        
                        Image("HomeTopImage")
                            .resizable()
                            .scaledToFit()
                        
                        //            .frame(width: 300, alignment: .top)
                        //            .padding()
                        //            .background(Color.white)
                            .mask(LinearGradient(gradient: Gradient(colors: [Color.red, Color.red, Color.red, Color.blue.opacity(0)]), startPoint: .top, endPoint: .bottom))
                        VStack(spacing: 5) {
                            Text("Kinestex").font(.title)
                            Text("AI training").font(.title2)
                            Text("Train your body with AI")
                        }
                        .foregroundColor(.white)
                    }
                    
                    //                Trending start
                    VStack {
                        HStack {
                            Text("Trending")
                                .font(.title)
                            Spacer()
                            Link("show all", destination: URL(string: "https://google.com")!)
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(firebaseManager.workouts){ workout in
                                    if workout.is_trending { // Checking if workout is trending
                                        NavigationLink(destination: WorkoutDescriptionView(workout: workout), label: {
                                            TrendingCardsView(workout: workout)
                                                .frame(width: 250, height: 150)
                                                .cornerRadius(10)
                                            //                                Image(systemName: "rectangle.fill")
                                            //                                    .font(.system(size: 100))
                                            //                                    .foregroundColor(.yellow)
                                        })
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                    //                Trending end
                    Divider()
                    //                Categories start
                    VStack {
                        HStack {
                            Text("Categories")
                                .font(.title)
                            Spacer()
                            Link("show all", destination: URL(string: "https://google.com")!)
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 10) {
                                ForEach(0..<10){ index in
                                    ZStack {
                                        Image("HomeTopImage")
                                            .resizable()
                                            .scaledToFill()
                                        HStack {
                                            VStack(alignment: .leading) {
                                                
                                                Text("Category")
                                                    .font(Font.headline.weight(.bold))
                                                
                                            }
                                            .foregroundColor(.white)
                                            .padding(.horizontal)
                                            Spacer()
                                        }
                                    }
                                    .frame(width: 200, height: 100)
                                    .cornerRadius(10)
                                }
                            }
                            .padding()
                        }
                    }
                    //                Categories end
                    
                    Divider()
                    
                    //                Constructor start
                    
                    ZStack {
                        VStack {
                            Image("HomeTopImage")
                                .resizable()
                            //                                .aspectRatio(contentMode: .fill)
                            //                                .scaledToFill()
                            
                        }
                        
                        .clipped()
                        .cornerRadius(10)
                        
                        
                        VStack {
                            Text("Workout Creator")
                                .font(Font.title.bold())
                            Text("Create your own workout. Select from a wide pool of exercises...")
                                .padding(.horizontal)
                            Button("Let's get started", action: {
                                print("hello")
                            })
                                .buttonStyle(.borderless)
                                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                .background(Color.green)
                                .cornerRadius(10)
                            
                        }
                        .foregroundColor(.white)
                    }
                    .frame(width: 340, height: 170)
                    
                    
                    Divider()
                    
                    VStack {
                        HStack {
                            Text("Bonus")
                                .font(.title)
                            Spacer()
                            Link("show all", destination: URL(string: "https://google.com")!)
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 10) {
                                ForEach(0..<10){ index in
                                    Image(systemName: "app.fill")
                                        .font(.system(size: 100))
                                        .foregroundColor(.yellow)
                                }
                            }
                            .padding()
                        }
                    }
                    
                    
                }
            }
            .ignoresSafeArea(edges: .top)
            .navigationTitle("Kinestex")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                firebaseManager.workoutsGet()
            })
            //            .navigationBarHidden(true)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
