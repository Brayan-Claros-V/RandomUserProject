//
//  UserDataManager.swift
//  RandomUser
//
//  Created by Brayan Claros on 9/9/25.
//

import CoreData

class UserDataManager: UserRepositoryProtocol {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func saveUser(name: String, email: String, picture: String?) {
        let user = FUser(context: context)
        user.name = name
        user.email = email
        
        do {
            try context.save()
        } catch {
            print("Error")
        }
    }
    
    func showUsers() -> [FUser] {
        let request: NSFetchRequest<FUser> = FUser.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    func deleteUser(_ user: FUser) {
        context.delete(user)
        
        do {
            try context.save()
        } catch {
            print("Error")
        }
    }
    
    
    
}
