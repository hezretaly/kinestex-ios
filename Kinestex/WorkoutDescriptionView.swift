//
//  WorkoutDescriptionView.swift
//  Kinestex
//
//  Created by Hezzi Amanaly on 2/20/22.
//

import SwiftUI


struct SheetView: View {
//    @Environment(\.presentationMode) var presentationMode
    
//    var description: String

    var body: some View {
        Text("Hello, this is a sheet swipe down to close")
            .padding()
        
//        Text(description+" exercise")
//            .bold()
//            .padding()
            
//        Button("Press to dismiss") {
//            presentationMode.wrappedValue.dismiss()
//        }
//        .font(.title)
//        .padding()
//        .background(Color.black)
    }
}

extension Int: Identifiable {
    public var id: Int { self }
}

struct WorkoutDescriptionView: View {
    
    //    @State private var showingSheet = false
//    @ObservedObject var url: LoadUrlImage
    
    var workout: WorkoutsModel
    @State private var index: Int? = nil
    
//    init(workout: WorkoutsModel) {
//        self.workout = workout
//        url = LoadUrlImage(imageURL: workout.imgURL)
//    }
    
//    @State private var selectedMovie: Int? = nil
//    @State private var isPresented: Bool = false
    
    var movies = ["Harry potter", "Mad Max", "Oblivion", "Memento"]
    
//    Main picture
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
            ScrollView {
//                Image(uiImage: UIImage(data: self.url.data) ?? UIImage())
//                    .resizable()
//                    .scaledToFit()
//                WorkoutImageFitView(uiImage: workout.uiImage!)
                Image(uiImage: img)
                    .resizable()
                    .scaledToFit()
                
                Text(workout.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                
                Text(workout.expandedDes)
                    .font(.body)
                    .padding(10)
                
                Button(action: {
                    print("Eyo!")
                }, label: {
                    Text("Start")
                        .bold()
                        .font(.title2)
                        .frame(width: 350, height: 50)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
                    .padding(.bottom)
                
                VStack (alignment: .leading, spacing: 10) {
                    Label("Bookmark", systemImage: "bookmark")
                    
                    Label("\(workout.totalTime) mins", systemImage: "stopwatch")
                    
                    Label(workout.difLevel, systemImage: "speedometer")
                    
                    Label(workout.body_parts, systemImage: "figure.wave")
                }
                .padding(.bottom)
                
                
                VStack (alignment: .leading, spacing: 4) {
                    Text("Training Vieos")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.vertical)
                    ForEach(workout.videosDes) { video in
                        HStack {
                            Image("HomeTopImage")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                            
                            VStack {
                                Text(video.title)
                                    .font(.title)
                                
                                Text(video.description)
                                    .lineLimit(2)
                            }
                            
                            Spacer()
                        }
//                        .padding(.leading, 10)
                        .onTapGesture {
                            self.index = workout.videosDes.firstIndex(where: {$0.id==video.id})!
//                            self.isPresented.toggle()
                        }
                        
                    }
//                        .sheet(item: self.$selectedMovie) { item in
//                            SheetView()
//                            //SheetView(description: self.movies[$0])
//                        }
                }
                .padding(.leading, 20)
            }
            .onAppear {
                ImageCache.loadImage(urlString: workout.imgURL, completion: setImg)
            }
            .sheet(item: self.$index) {
                WorkoutDesVideoPreView(vd: self.workout.videosDes[$0])
                //SheetView(description: self.movies[$0])
            }
//        Only available in ios 15
//                .safeAreaInset(edge: .top) {
//                HStack {
//
//                }
//            }

    }
}


struct WorkoutDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WorkoutDescriptionView(workout: WorkoutsModel())
        }
    }
}


