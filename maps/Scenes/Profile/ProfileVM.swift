//
//  ProfileVM.swift
//  maps
//
//  Created by mohamad ghonem on 19/01/2025.
//

import Foundation


class ProfileVM: BaseViewModel{
    private var user: User?
    
    override init() {
        super.init()
        
        user = getUserFromUserDefaults(name: .savedUser)
    }
    
    ///returns the user's first name
    func getFirstName() -> String {
        guard let user = user else {
            return ""
        }
        return user.firstName
    }
    
    ///returns the user's last name
    func getLastName() -> String {
        guard let user = user else {
            return ""
        }
        return user.lastName
    }
    
    ///returns the user's age
    func getAge() -> String {
        guard let user = user else {
            return ""
        }
        return String(user.age)
    }
    
    ///returns the user's email
    func getemail() -> String {
        guard let user = user else {
            return ""
        }
        return String(user.email)
    }
}
