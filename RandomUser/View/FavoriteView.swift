//
//  FavoriteView.swift
//  RandomUser
//
//  Created by Brayan Claros on 9/9/25.
//

import SwiftUI

struct FavoriteView: View {
    let environment: AppEnvironment
    @State private var favorites: [FUser] = []
    
    var body: some View {
        NavigationView {
            List {
                if favorites.isEmpty {
                    Text("You don't have any favorites yet!")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(favorites, id: \.objectID) { user in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(user.name ?? "")
                                    .font(.headline)
                                Text(user.email ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            
                        }
                        .padding(.vertical, 4)
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let userToDelete = favorites[index]
                            environment.userRepository.deleteUser(userToDelete)
                        }
                        loadFavorites()
                    }
                }
            }
            .navigationTitle("Favorites")
            .onAppear {
                loadFavorites()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
    
    private func loadFavorites() {
        favorites = environment.userRepository.showUsers() as? [FUser] ?? []
    }
}
