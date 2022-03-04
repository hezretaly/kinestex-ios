//
//  WorkoutsModel.swift
//  Kinestex
//
//  Created by Hezzi Amanaly on 2/24/22.
//

import Foundation
import Firebase
import FirebaseDatabase
// Combine is must for ObservableObject protocol in other words it is Combine's protocol
import Combine

struct Exercise {
    let countdown: String
    let tv: String
    let videoURL: String
}

//struct WorkoutDis {
//    let expandedDescription: String?
//    let imageWorkoutDis: String?
//    let videosDis: [VideoDes]?
//}

struct WorkoutsModel: Identifiable {
    var id = UUID()
    var body_parts: String = ""
//    var bot_available: Bool
//    var calories: Int = 0
//    var category: String = ""
    var difLevel: String = ""
//    var exercises: [Exercise]?
    var imgURL: String = ""
    var is_trending: Bool = false
    var sub_category: String = ""
    var title: String = ""
//    var title_ru: String = ""
    var totalTime: Int = 0
    var expandedDes: String = ""
    var videosDes: [VideoDes] = []
//    var workout_img: UIImage = UIImage()
//    var videoURL: String = ""
//    var workoutDis: [WorkoutDis]?
    
//    var woutImage: UIImage? //= UIImage(imageLiteralResourceName: "CategoryImage1")
    
//    mutating func setImage(_ imgUrl: String,_ img: UIImage?) -> Void {
////        guard img = img as? UIImage else {
////            return
////        }
//
//        if woutImage != nil && woutImage!.isEqual(img) {
//            // Images are the same no reassigning is needed.
//            return
//        }
//        woutImage = img
//    }
    
//    init(body_parts: String?, bot_available: Bool?, calories: Int?, category: String?, difLevel: String?, is_trending: Bool?, sub_category: String?, title: String?, title_ru: String?, totalTime: Int?, videoURL: String?){
//        self.body_parts = body_parts;
//        self.bot_available = bot_available;
//        self.calories = calories;
//        self.category = category;
//        self.difLevel = difLevel;
//        self.is_trending = is_trending;
//        self.sub_category = sub_category;
//        self.title = title;
//        self.title_ru = title_ru;
//        self.totalTime = totalTime;
//        self.videoURL = videoURL;
//    }
}

struct NewsLoop: Identifiable {
    var id = UUID()
    var author: String = ""
    var category: String = ""
    var duration: Int = 0
    var imgURL: String = ""
    var text: String = ""
    var time: String = ""
    var title: String = ""
}

struct NewsRec: Identifiable {
    var id = UUID()
    var author: String = ""
    var category: String = ""
    var duration: Int = 0
    var imgURL: String = ""
    var text: String = ""
    var time: String = ""
    var title: String = ""
}

struct TopCategory: Identifiable {
    var id = UUID()
    var imgURL: String = ""
    var title: String = ""
}

struct News {
    var newsLoop: [NewsLoop] = []
    var newsRec: [NewsRec] = []
    var topCategory: [TopCategory] = []
}

class Workout: ObservableObject {
    @Published var workouts: [WorkoutsModel] = []
}


class FirebaseManager: ObservableObject {
    @Published var workouts: [WorkoutsModel] = [] //? = nil
    @Published var news = News()
    var ref: DatabaseReference!
//    @StateObject var workout = Workout()
//    var workout: WorkoutsModel = WorkoutsModel()
    
//    Tableview in uikit
    
    func makeFirebaseCall() -> Void {
        print("in the beggining")
        ref=Database.database().reference()
        print("after ref-ed")
        ref.child("workouts").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? NSDictionary else {
                print("there is no data?")
                return
            }
            for (key, value) in value {
                print("Value: \(value) for key: \(key)")
                
            }
            let body_parts = value["body_parts"] as? String ?? ""
            print(" Hello!!! ")
            print(body_parts)
        })
        print("at the end")
        
//        Makes bunch of errors
//        ref.child("workouts").child("Breathing Workout").observeSingleEvent(of: .value, with: {
//            snapshot in
//            self.workoutModel = WorkoutsModel(snapshot.value) as? WorkoutsModel
//            print(self.workoutModel?.title)
//            print("hello here is testing")
//        })
    }
    
//if snapshot.childrenCount > 0{
//for childInsideWorkouts in snapshot.children.allObjects as! [DataSnapshot]{
////теперь мы во всех тренировках и создаем лист со всеми key, value парами
//let Object = childInsideWorkouts.value as? [String: AnyObject]
////берем элементы собственно
//let title = Object?["title"] as! String
//let imgURL = Object?["videoURL"] as! String
//let difLevel = Object?["difLevel"] as! String
//let totalTime = Object?["totalTime"] as! Int
//
//
//    print(title)
//    print(totalTime)
////list.append(Model(title,imgURL,difLevel, totalTime))
////trendingSwipeView.notifyThatThere's An Update in the list() values - in case you want to update when AN element is loaded
//print("Counter: \(childInsideWorkouts.childrenCount)")
    
    func workoutsGet() -> Void {
        if self.workouts.count > 0 {
            return
        }
//        var workouts: [WorkoutsModel]
        ref=Database.database().reference()
//        print("after ref-ed")
        ref.child("workouts").observeSingleEvent(of: DataEventType.value, with: { snapshot in
//            let value = snapshot.value as? NSDictionary
//            print("children count \(snapshot.childrenCount)")
//            print(snapshot)
            if snapshot.childrenCount > 0{
                for childInsideWorkouts in snapshot.children.allObjects as! [DataSnapshot]{
                    let Object = childInsideWorkouts.value as? [String: AnyObject]
                    var workout = WorkoutsModel()
                    workout.title = Object?["title"] as! String
                    workout.body_parts = Object?["body_parts"] as! String
                    workout.totalTime = Object?["totalTime"] as! Int
                    workout.difLevel = Object?["difLevel"] as! String
                    workout.is_trending = Object?["is_trending"] as! Bool
                    workout.sub_category = Object?["sub_category"] as! String
                    workout.imgURL = Object?["imgURL"] as! String
                    workout.expandedDes = Object?["workoutDis"]?["expandedDescription"] as! String
                    for videosChild in childInsideWorkouts.childSnapshot(forPath: "workoutDis/videosDis").children.allObjects as! [DataSnapshot] {
                        let Object = videosChild.value as? [String: AnyObject]
                        var videoDes = VideoDes()
                        videoDes.videoUrl = Object?["videoURL"] as! String
                        videoDes.title = Object?["title"] as! String
                        videoDes.description = Object?["description"] as! String
                        workout.videosDes.append(videoDes)
                    }
//                    workout.uiImage = UiImageModel(urlString: workout.imgURL)
//                    print(workout)
//                    print(self.workouts)
                    self.workouts.append(workout)
                }
            }
//            guard let value = snapshot.value as? NSDictionary else {
//                print("there is no data?")
//                return
//            }
//            let decoded: [WorkoutsModel] = try! JSONDecoder().decode([WorkoutsModel].self, from: value)
//            let blogPosts: [BlogPost] = try! JSONDecoder().decode([BlogPost].self, from: jsonData)
//            print(blogPosts.count) // Prints: 3
//            print(decoded.count)
//            for (_, value) in snapshot {
//                let val = value as? NSDictionary
//                let title = value["title"]
//                print(title)
//                workout.title = title
//                print(workout.title)
//                print("Value: \(value) for key: \(key)")
//                guard let workout = value as? [String: Any],
//                     let title = workout ["title"] as? String else {
//                          print("Nothing was returned in title")
//                         return
//                      }
//                if title is String {
//                    workout.title = title
//                }
//                guard let sub_category = workout ["sub_category"] as? String else {
//                    print("Nothing was returned in sub_category")
//                    return
//                }
//                print("Training title: \(title) \t Sub category: \(sub_category)")
//
//                guard let workoutDis = workout ["workoutDis"] as? NSDictionary else {
//                    print("no workoutDis")
//                    return
//                }
//                guard let expandedDescription = workoutDis ["expandedDescription"] as? String else {
//                    print("no expandedDescription")
//                    return
//                }
//                print("workout dis: \(expandedDescription)")
//
//                guard let videosDis = workoutDis ["videosDis"] as? NSDictionary else {
//                    print("no videosDis")
//                    return
//                }
//
//                for (_, value) in videosDis {
//                    guard let vid = value as? [String: Any],
//                          let title = vid ["title"] as? String else {
//                              print("no videosDis vids")
//                              return
//                          }
//                    print("vid title: \(title)")
//                }

//            }
        }){ error in
            print(error.localizedDescription)
          }
    }
    
    func articlesGet() -> Void {
        if self.news.newsLoop.count > 0 {
            return
        }
        ref=Database.database().reference()
        ref.child("news").child("news_loop").observeSingleEvent(of: DataEventType.value, with: { snapshot in
            if snapshot.childrenCount > 0{
                for childInsideWorkouts in snapshot.children.allObjects as! [DataSnapshot]{
                    let Object = childInsideWorkouts.value as? [String: AnyObject]
                    var newsLoop = NewsLoop()
                    newsLoop.title = Object?["title"] as! String
                    newsLoop.category = Object?["category"] as! String
                    newsLoop.duration = Object?["duration"] as! Int
                    newsLoop.text = Object?["text"] as! String
                    newsLoop.time = Object?["time"] as! String
                    newsLoop.author = Object?["author"] as! String
                    newsLoop.imgURL = Object?["imgURL"] as! String
                    self.news.newsLoop.append(newsLoop)
                }
            }
        }){ error in
            print(error.localizedDescription)
          }
        ref.child("news").child("news_rec").observeSingleEvent(of: DataEventType.value, with: { snapshot in
            if snapshot.childrenCount > 0{
                for childInsideWorkouts in snapshot.children.allObjects as! [DataSnapshot]{
                    let Object = childInsideWorkouts.value as? [String: AnyObject]
                    var newsRec = NewsRec()
                    newsRec.title = Object?["title"] as! String
                    newsRec.category = Object?["category"] as! String
                    newsRec.duration = Object?["duration"] as! Int
                    newsRec.text = Object?["text"] as! String
                    newsRec.time = Object?["time"] as! String
                    newsRec.author = Object?["author"] as! String
                    newsRec.imgURL = Object?["imgURL"] as! String
                    self.news.newsRec.append(newsRec)
                }
            }
        }){ error in
            print(error.localizedDescription)
          }
        ref.child("news").child("topCategory").observeSingleEvent(of: DataEventType.value, with: { snapshot in
            if snapshot.childrenCount > 0{
                for childInsideWorkouts in snapshot.children.allObjects as! [DataSnapshot]{
                    let Object = childInsideWorkouts.value as? [String: AnyObject]
                    var topCategory = TopCategory()
                    topCategory.title = Object?["title"] as! String
                    topCategory.imgURL = Object?["imgURL"] as! String
                    self.news.topCategory.append(topCategory)
                }
            }
        }){ error in
            print(error.localizedDescription)
          }
    }
    
}

// LoadUrlImage is Temporarily here

//class LoadUrlImage: ObservableObject {
//    @Published var data = Data()
//    init(imageURL: String) {
//        let cache = URLCache.shared
//        let request = URLRequest(url: URL(string: imageURL)!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 60.0)
//        if let data = cache.cachedResponse(for: request)?.data {
//            self.data = data
//        } else {
//            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
//                if let data = data, let response = response {
//                let cachedData = CachedURLResponse(response: response, data: data)
//                                    cache.storeCachedResponse(cachedData, for: request)
//                    DispatchQueue.main.async {
//                        self.data = data
//                    }
//                }
//            }).resume()
//        }
//    }
//}

// Below is more sleek implementation of image caching

//class RemoteImageModel: ObservableObject {
//    @Published var displayImage: UIImage?
//    var imageUrl: String?
//    var cachedImage = CachedImage.getCachedImage()
//
//    init(imageUrl: String?) {
//        self.imageUrl = imageUrl
//        if imageFromCache() {
//            return
//        }
//        imageFromRemoteUrl()
//    }
//
//
//    func imageFromCache() -> Bool {
//        guard let url = imageUrl, let cacheImage = cachedImage.get(key: url) else {
//            return false
//        }
//        displayImage = cacheImage
//        return true
//    }
//
//    func imageFromRemoteUrl() {
//        guard let url = imageUrl else {
//            return
//        }
//
//        let imageURL = URL(string: url)!
//
//        URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, response, error) in
//            if let data = data {
//                DispatchQueue.main.async {
//                    guard let remoteImage = UIImage(data: data) else {
//                        return
//                    }
//
//                    self.cachedImage.set(key: self.imageUrl!, image: remoteImage)
//                    self.displayImage = remoteImage
//                }
//            }
//            }).resume()
//    }
//}
//
//class CachedImage {
//    var cache = NSCache<NSString, UIImage>()
//
//    func get(key: String) -> UIImage? {
//        return cache.object(forKey: NSString(string: key))
//    }
//
//    func set(key: String, image: UIImage) {
//        cache.setObject(image, forKey: NSString(string: key))
//    }
//}
//
//extension CachedImage {
//    private static var cachedImage = CachedImage()
//    static func getCachedImage() -> CachedImage {
//        return cachedImage
//    }
//}
//

//extension Employee: Decodable {
//  init(from decoder: Decoder) throws {
//    let container = try decoder.container(keyedBy: CodingKeys.self)
//    name = try container.decode(String.self, forKey: .name)
//    id = try container.decode(Int.self, forKey: .id)
//    let giftContainer = try container
//      .nestedContainer(keyedBy: GiftKeys.self, forKey: .gift)
//    favoriteToy = try giftContainer.decode(Toy.self, forKey: .toy)
//  }
//}

//let sameEmployee = try decoder.decode(Employee.self, from: nestedData)

//Let's try my own thing

//public enum Result<T> {
//    case success(T)
//    case failure(NSError)
//}
//
//class CacheManager {
//
//    static let shared = CacheManager()
//    private let fileManager = FileManager.default
//    private lazy var mainDirectoryUrl: URL = {
//
//        let documentsUrl = self.fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
//        return documentsUrl
//    }()
//
//    func getFileWith(stringUrl: String, completionHandler: @escaping (Result<URL>) -> Void ) {
//
//        let file = directoryFor(stringUrl: stringUrl)
//
//        //return file path if already exists in cache directory
//        guard !fileManager.fileExists(atPath: file.path)  else {
//            completionHandler(Result.success(file))
//            return
//        }
//
//        DispatchQueue.global().async {
//
//            if let videoData = NSData(contentsOf: URL(string: stringUrl)!) {
//                videoData.write(to: file, atomically: true)
//                DispatchQueue.main.async {
//                    completionHandler(Result.success(file))
//                }
//            } else {
//                DispatchQueue.main.async {
//                    let error = NSError(domain: "SomeErrorDomain", code: -2001 /* some error code */, userInfo: ["description": "Can't download video"])
//
//                    completionHandler(Result.failure(error))
//                }
//            }
//        }
//    }
//
//    private func directoryFor(stringUrl: String) -> URL {
//
//        let fileURL = URL(string: stringUrl)!.lastPathComponent
//        let file = self.mainDirectoryUrl.appendingPathComponent(fileURL)
//        return file
//    }
//}
