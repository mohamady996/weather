//
//  WeatherResponseModel.swift
//  Weather
//
//  Created by mohamad ghonem on 17/02/2025.
//

import Foundation



// MARK: - WeatherResponseModel
struct WeatherResponseModel: Codable {
    let current: Current?
    let forecast: Forecast?
}

// MARK: - Current
struct Current: Codable {
    let lastUpdated: String?
    let tempC, tempF: Double?
    let isDay: Int?
    let condition: Condition?
    let windMph, windKph: Double?
    let windDegree: Int?
    let windDir: String?
    let humidity: Int?
    
    enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case humidity
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text, icon: String?
}

// MARK: - Forecast
struct Forecast: Codable {
    let forecastday: [Forecastday]?
}

// MARK: - Forecastday
struct Forecastday: Codable {
    let date: String?
    let day: Day?
}

// MARK: - Day
struct Day: Codable {
    let avgtempC, avgtempF, maxwindMph, maxwindKph: Double?
    let avghumidity: Int?
    let condition: Condition?
    
    enum CodingKeys: String, CodingKey {
        case avgtempC = "avgtemp_c"
        case avgtempF = "avgtemp_f"
        case maxwindMph = "maxwind_mph"
        case maxwindKph = "maxwind_kph"
        case avghumidity, condition
    }
}
