//
//  User.swift
//  maps
//
//  Created by mohamad ghonem on 19/01/2025.
//

import Foundation

///The information of the signed in user
struct User: Codable {
    let firstName, lastName: String
    let age: Int
    let email, password: String
}
