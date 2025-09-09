//
//  UserDetailView.swift
//  RandomUser
//
//  Created by Brayan Claros on 8/9/25.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
                .cornerRadius(8)
            
            VStack(spacing: 16) {
                if let url = URL(string: user.picture.medium) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.3)
                    }
                    .frame(width: 90, height: 90)
                    .clipShape(Circle())
                    .shadow(radius: 4)
                }

                Text("\(user.name.first) \(user.name.last)")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(user.gender.capitalized)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }

        .padding()
        .navigationTitle("User Detail")
    }
}

