//
//  User.swift
//  RandomUser
//
//  Created by Brayan Claros on 5/9/25.
//

import Foundation

struct RandomUserResponse: Decodable {
    let results: [User]
}

struct User: Identifiable, Decodable {
    var id: String { login.uuid }
    let login: Id
    let name: Name
    let email: String
    let picture: Picture
    let gender: String

    var fullName: String { "\(name.first) \(name.last)" }
    var photoURL: URL? { URL(string: picture.medium) }
}

struct Id: Decodable {
    let uuid: String
}

struct Name: Decodable {
    let first: String
    let last: String
}

struct Picture: Decodable {
    let medium: String
}

