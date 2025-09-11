//
//  FavoriteViewModel.swift
//  RandomUser
//
//  Created by Brayan Claros on 10/9/25.
//

import Foundation
import CoreData

@MainActor
class FavoriteViewModel: ObservableObject {
    @Published private(set) var favorites: [FUser] = []
    
    private let repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol) {
        self.repository = repository
        loadFavorites()
    }
    
    func loadFavorites() {
        favorites = repository.showUsers()
    }
    
    func isFavorite(email: String) -> Bool {
        favorites.contains { $0.email == email }
    }
    
    func addFavorite(user: User) {
        repository.saveUser(
            name: "\(user.name.first) \(user.name.last)",
            email: user.email
        )
        loadFavorites()
    }
    
    func removeFavorite(byEmail email: String) {
        if let existing = favorites.first(where: { $0.email == email }) {
            repository.deleteUser(existing)
            loadFavorites()
        }
    }
    
    func toggleFavorite(user: User) {
        if isFavorite(email: user.email) {
            removeFavorite(byEmail: user.email)
        } else {
            addFavorite(user: user)
        }
    }
}
