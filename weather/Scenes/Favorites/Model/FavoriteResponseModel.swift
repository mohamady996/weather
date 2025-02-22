//
//  FavoriteResponseModel.swift
//  weather
//
//  Created by mohamad ghonem on 22/02/2025.
//

import Foundation

// MARK: - FavoriteResponseModel
struct FavoriteResponseModel: Codable {
    let location: FavoriteLocation?
    let current: FavoriteCurrent?
}

// MARK: - Current
struct FavoriteCurrent: Codable {
    let lastUpdated: String?
    let tempC: Double?
    let tempF: Double?
    let condition: FavoriteCondition?
    let windMph, windKph: Double?
    let windDegree: Int?
    let windDir: String?
    let humidity: Int?

    enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case humidity
    }
}

// MARK: - Condition
struct FavoriteCondition: Codable {
    let text, icon: String?
}

// MARK: - Location
struct FavoriteLocation: Codable {
    let name: String?
}
