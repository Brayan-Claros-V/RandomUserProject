//
//  Actions.swift
//  RandomUser
//
//  Created by Brayan Claros on 12/9/25.
//

enum UserAction {
    case loadUsers
    case setUsers([User])
    case setQuery(String)
    case setError(String)
    case setLoading(Bool)
}
