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
    @StateObject private var viewModel: UserListViewModel
    @StateObject private var favoriteVM: FavoriteViewModel
    
    init(environment: AppEnvironment) {
        self.environment = environment
        _viewModel = StateObject(wrappedValue:
        UserListViewModel(service: environment.userService))
        _favoriteVM = StateObject(wrappedValue:
        FavoriteViewModel(repository: environment.userRepository))
    }
    
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    TextField("Search Users...", text: $viewModel.query)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                    if(viewModel.users.isEmpty) {
                        Text("No users available")
                    }
                    
                    List(viewModel.users) { user in
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
                            if user.id == viewModel.users.last?.id {
                                Task {
                                    await viewModel.loadUsers()
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
            await viewModel.loadUsers()
        }
    }
}

#Preview {
    ContentView(environment: .init())
}
