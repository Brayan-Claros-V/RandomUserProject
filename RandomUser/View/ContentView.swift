//
//  ContentView.swift
//  RandomUser
//
//  Created by Brayan Claros on 5/9/25.
//

import SwiftUI
import CoreData

@MainActor
struct ContentView: View {
    let environment: AppEnvironment
    @StateObject private var store: UserStore
    @StateObject private var favoriteVM: FavoriteViewModel

    init(environment: AppEnvironment) {
        self.environment = environment
        _store = StateObject(wrappedValue: UserStore(service: environment.userService, reducer: userReducer))
        _favoriteVM = StateObject(wrappedValue: FavoriteViewModel(repository: environment.userRepository))
    }

    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    TextField("Search Users...", text: Binding(
                        get: { store.state.query },
                        set: { store.updateQuery($0) }
                    ))
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    
                    if store.state.filteredUsers.isEmpty {
                        Text("No users available")
                            .foregroundColor(.gray)
                            .padding()
                    }

                    List(store.state.filteredUsers) { user in
                        NavigationLink {
                            UserDetailView(user: user)
                        } label: {
                            HStack(alignment: .center, spacing: 12) {
                                if let url = URL(string: user.picture.medium) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        Color.gray.opacity(0.3)
                                    }
                                    .frame(width: 90, height: 90)
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.black.opacity(0.7), lineWidth: 2)
                                    )
                                    .shadow(radius: 2)
                                } else {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 90, height: 90)
                                        .cornerRadius(8)
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text("\(user.name.first) \(user.name.last)")
                                        .font(.headline)
                                    Text(user.email)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()

                                Button {
                                    favoriteVM.toggleFavorite(user: user)
                                } label: {
                                    let isFav = favoriteVM.isFavorite(email: user.email)
                                    Image(systemName: isFav ? "star.fill" : "star")
                                        .foregroundColor(isFav ? .yellow : .gray)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.vertical)
                        .onAppear {
                            if user.id == store.state.filteredUsers.last?.id {
                                Task {
                                    store.dispatch(.loadUsers)
                                }
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                    .navigationBarTitle("Random Users")
                }
            }
            .tabItem {
                Label("Users", systemImage: "person.3")
            }

            FavoriteView(environment: environment)
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
        .task {
            store.dispatch(.loadUsers)
        }
    }
}


#Preview {
    ContentView(environment: .init())
}
