//
//  AppEnvironment.swift
//  RandomUser
//
//  Created by Brayan Claros on 8/9/25.
//

import Foundation

final class AppEnvironment {
    let userService: UserServiceProtocol
    let userRepository: UserRepositoryProtocol
    
    init(
        userService: UserServiceProtocol = UserService(),
        userRepository: UserRepositoryProtocol = UserDataManager(context: PersistenceController.shared.container.viewContext)
    ) {
        self.userService = userService
        self.userRepository = userRepository
    }
}

