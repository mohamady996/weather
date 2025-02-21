//
//  savedObjects.swift
//  Weather
//
//  Created by mohamad ghonem on 17/02/2025.
//

import Foundation

///The name of the saved objects inside of UserDefaults
enum savedObjects: String {
    case preferredTemperatureUnit = "preferredTemperatureUnit"
    case favouriteLocations = "favouriteLocations"
    case tempAsCelcius = "tempAsCelcius"
    case defaultCity = "defaultCity"
    case favorityCityArray = "favorityCityArray"
}
