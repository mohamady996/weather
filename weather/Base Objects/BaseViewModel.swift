//
//  BaseViewModel.swift
//  Weather
//
//  Created by mohamad ghonem on 17/02/2025.
//

import Foundation

class BaseViewModel{
    
    ///saves Bool in the UserDefaults
    func saveBoolToUserDefaults(value: Bool, name: savedObjects) {
        UserDefaults.standard.set(value, forKey: name.rawValue) //Bool
    }
    
    ///retrieves Bool from UserDefaults
    func getBoolFromUserDefaults(name: savedObjects) -> Bool? {
        return UserDefaults.standard.bool(forKey: name.rawValue) //Bool
    }
    
    ///saves String in the UserDefaults
    func saveStringToUserDefaults(value: String, name: savedObjects) {
        UserDefaults.standard.set(value, forKey: name.rawValue)
    }
    
    ///retrieves String from UserDefaults
    func getStringFromUserDefaults(name: savedObjects) -> String? {
        return UserDefaults.standard.string(forKey: name.rawValue)
    }
}
