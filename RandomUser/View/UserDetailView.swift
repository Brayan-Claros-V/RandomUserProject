//
//  UserDetailView.swift
//  RandomUser
//
//  Created by Brayan Claros on 8/9/25.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        VStack {
            Text("\(user.name.first) \(user.name.last)")
                .font(.headline)
            Text("\(user.email)")
        }
    }
}
