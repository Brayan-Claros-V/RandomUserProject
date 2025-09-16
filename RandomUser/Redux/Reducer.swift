//
//  Reducer.swift
//  RandomUser
//
//  Created by Brayan Claros on 12/9/25.
//

import Foundation

func userReducer(state: AppState, action: UserAction) -> AppState {
    var newState = state
    switch action {
    case .setLoading(let loading):
        newState.isLoading = loading

    case .setUsers(let newUsers):
        newState.allUsers += newUsers
        newState.currentPage += 1
        newState.filteredUsers = filterUsers(all: newState.allUsers, query: newState.query)
        newState.isLoading = false

    case .setQuery(let query):
        newState.query = query
        newState.filteredUsers = filterUsers(all: newState.allUsers, query: query)

    case .setError(let message):
        newState.errorMessage = message
        newState.isLoading = false

    case .loadUsers:
        newState.isLoading = true
    }
    return newState
}

private func filterUsers(all: [User], query: String) -> [User] {
    let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    guard !trimmed.isEmpty else { return all }

    return all.filter {
        $0.fullName.lowercased().contains(trimmed) ||
        $0.email.lowercased().contains(trimmed)
    }
}

