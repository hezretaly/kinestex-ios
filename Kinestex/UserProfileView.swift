//
//  UserProfileView.swift
//  Kinestex
//
//  Created by Hezzi Amanaly on 2/23/22.
//

import SwiftUI

struct UserProfileView: View {
    
    @State private var firstNmae = ""
    @State private var lastNmae = ""
    @State private var company = ""
    
    var body: some View {
        NavigationView {
            VStack {
                ProfileImage(imageName: "HomeTopImage")
                    .padding()
                
                Form {
                    Section(header: Text("Personal Info")) {
                        TextField("First Name", text: $firstNmae)
                        TextField("Last Name", text: $lastNmae)
                        TextField("Company", text: $company)
                    }
                }
            }
            .navigationTitle("Profile")
            .toolbar {
                Button {
                    print("Saved")
                } label: {
                    Label("Save", systemImage: "square.and.arrow.down")
                }
            }
            
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}

struct ProfileImage: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
    }
}
