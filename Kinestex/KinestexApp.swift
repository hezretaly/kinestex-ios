//
//  KinestexApp.swift
//  Kinestex
//
//  Created by Hezzi Amanaly on 2/19/22.
//

import SwiftUI
import Firebase
import FirebaseDatabase

@main
struct KinestexApp: App {
    init() {
        FirebaseApp.configure()
        FirebaseDatabase.Database.database().isPersistenceEnabled = true
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
