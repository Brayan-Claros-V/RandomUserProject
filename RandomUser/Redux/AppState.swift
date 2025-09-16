//
//  AppState.swift
//  RandomUser
//
//  Created by Brayan Claros on 12/9/25.
//

struct AppState {
    var allUsers: [User] = []
    var filteredUsers: [User] = []
    var query: String = ""
    var currentPage: Int = 1
    var isLoading: Bool = false
    var errorMessage: String? = nil
}
