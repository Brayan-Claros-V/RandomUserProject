//
//  UserListViewModel.swift
//  RandomUser
//
//  Created by Brayan Claros on 5/9/25.
//

import Foundation

@MainActor
class UserListViewModel: ObservableObject {
    private var allUsers: [User] = []
    @Published var users: [User] = []
    private let service: UserServiceProtocol
    private var currentPage = 1
    private let resultsPerPage = 20
    
    @Published var query: String = "" {
        didSet {
            filterUsers()
        }
    }
    
    init(service: UserServiceProtocol) {
        self.service = service
    }
    
    func loadUsers() async {
        if let newUsers = try? await service.fetchUsers(page: currentPage, results: resultsPerPage) {
            allUsers.append(contentsOf: newUsers)
            filterUsers()
            currentPage += 1
        }
    }
    
    private func filterUsers() {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        if trimmedQuery.isEmpty {
            users = allUsers
        } else {
            users = allUsers.filter { user in
                let fullName = "\(user.name.first) \(user.name.last)".lowercased()
                return fullName.contains(trimmedQuery) ||
                       user.email.lowercased().contains(trimmedQuery)
            }
        }
    }
}

