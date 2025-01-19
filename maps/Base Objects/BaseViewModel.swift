//
//  BaseViewModel.swift
//  maps
//
//  Created by mohamad ghonem on 19/01/2025.
//

import Foundation

class BaseViewModel{
    
    ///saves the user in the UserDefaults
    func saveUserToUserDefaults(user: User, name: savedObjects) {
        let defaults = UserDefaults.standard
        if let encoded = try? JSONEncoder().encode(user) {
            defaults.set(encoded, forKey: name.rawValue)
        }
    }
    
    ///retrieves the user from UserDefaults
    func getUserFromUserDefaults(name: savedObjects) -> User? {
        guard let data = UserDefaults.standard.data(forKey: name.rawValue) else {
            return nil
        }
        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(User.self, from: data)
            return user
        } catch {
            return nil
        }
    }
}
