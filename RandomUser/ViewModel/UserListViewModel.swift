//
//  UserListViewModel.swift
//  RandomUser
//
//  Created by Brayan Claros on 5/9/25.
//

import Foundation

@MainActor
class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    
    private let service: UserServiceProtocol
    private var currentPage = 1
    private let resultsPerPage = 20
    
    
    init(service: UserServiceProtocol) {
        self.service = service
    }
    
    func loadUsers() async {
        if let newUsers = try? await service.fetchUsers(page: currentPage, results: resultsPerPage) {
            users.append(contentsOf: newUsers)
            currentPage += 1
        }
    }
}
