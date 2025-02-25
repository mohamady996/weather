//
//  SearchResponseModel.swift
//  weather
//
//  Created by mohamad ghonem on 21/02/2025.
//

import Foundation

// MARK: - SearchResponseModelElement
struct SearchResponseModelElement: Codable, Equatable {
    let id: Int?
    let name, region, country: String?
    let lat, lon: Double?
    let url: String?

    // Implement `Equatable` to allow comparisons
    static func == (lhs: SearchResponseModelElement, rhs: SearchResponseModelElement) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.region == rhs.region &&
               lhs.country == rhs.country &&
               lhs.lat == rhs.lat &&
               lhs.lon == rhs.lon &&
               lhs.url == rhs.url
    }
}

typealias SearchResponseModel = [SearchResponseModelElement]
