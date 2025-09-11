//
//  UserRepository.swift
//  RandomUser
//
//  Created by Brayan Claros on 9/9/25.
//

protocol UserRepositoryProtocol {
    func saveUser(name: String, email: String)
    func showUsers() -> [FUser]
    func deleteUser(_ user: FUser)
}
