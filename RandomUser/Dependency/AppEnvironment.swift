//
//  AppEnvironment.swift
//  RandomUser
//
//  Created by Brayan Claros on 8/9/25.
//

import Foundation

final class AppEnvironment {
    let userService: UserServiceProtocol
    
    init(
        userService: UserServiceProtocol = UserService()
    ) {
        self.userService = userService
    }
}

