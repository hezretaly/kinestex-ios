//
//  SettingView.swift
//  Kinestex
//
//  Created by Hezzi Amanaly on 3/7/22.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        Text("User")
            .font(.title3)
        List {
            Text("This is 1st")
            Text("This is 2nd")
            Text("This is 3rd")
        }
        Text("Units")
            .font(.title3)
        List {
            Text("This is 1st")
            Text("This is 2nd")
        }
        Text("Help")
            .font(.title3)
        List {
            Text("This is 1st")
            Text("This is 2nd")
            Text("This is 3rd")
        }
        
//        List {
//                    Section {
//                        TextField("Enter your word", text: $newWord)
//                    }
//
//                    Section {
//                        ForEach(usedWords, id: \.self) { word in
//                            Text(word)
//                        }
//                    }
//                }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
