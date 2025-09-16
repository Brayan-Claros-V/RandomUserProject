//
//  Store.swift
//  RandomUser
//
//  Created by Brayan Claros on 12/9/25.
//

import Foundation

@MainActor
class UserStore: ObservableObject {
    @Published private(set) var state: AppState
    private let reducer: (AppState, UserAction) -> AppState
    private let service: UserServiceProtocol

    init(initialState: AppState = AppState(), service: UserServiceProtocol, reducer: @escaping (AppState, UserAction) -> AppState) {
        self.state = initialState
        self.service = service
        self.reducer = reducer
    }

    func dispatch(_ action: UserAction) {
        state = reducer(state, action)

        if case .loadUsers = action {
            Task {
                await fetchUsers()
            }
        }
    }

    func updateQuery(_ query: String) {
        dispatch(.setQuery(query))
    }

    private func fetchUsers() async {
        do {
            let users = try await service.fetchUsers(page: state.currentPage, results: 20)
            dispatch(.setUsers(users))
        } catch {
            dispatch(.setError(error.localizedDescription))
        }
    }
}

