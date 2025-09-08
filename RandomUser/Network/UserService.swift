//
//  UserService.swift
//  RandomUser
//
//  Created by Brayan Claros on 5/9/25.
//

import Foundation

protocol UserServiceProtocol {
    func fetchUsers(page: Int, results: Int)
        async throws -> [User]
}

class UserService: UserServiceProtocol {
    func fetchUsers(page: Int = 1, results: Int = 20 ) async throws -> [User] {
        let url = URL(string: "https://randomuser.me/api/?results=\(results)&nat=us&page=\(page)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try
            JSONDecoder()
            .decode(RandomUserResponse.self, from: data)
        return decoded.results
    }
}

