//
//  MapResponseModel.swift
//  maps
//
//  Created by mohamad ghonem on 19/01/2025.
//

import Foundation

// MARK: - MapResponseModel
struct MapResponseModel: Codable {
    let meta: Meta?
    let response: Response?
}

// MARK: - Meta
struct Meta: Codable {
    let code: Int?
    let requestID: String?

    enum CodingKeys: String, CodingKey {
        case code
        case requestID = "requestId"
    }
}

// MARK: - Response
struct Response: Codable {
    let venues: [Venue]?
}

// MARK: - Venue
struct Venue: Codable {
    let name: String?
    let location: Location?
    let categories: [Category]?
}

// MARK: - Category
struct Category: Codable {
    let name: String?
    let icon: CategoryIcon?
    let categoryCode: Int?
    let mapIcon: String?
}

// MARK: - CategoryIcon
struct CategoryIcon: Codable {
    let iconPrefix: String?
    let suffix: Suffix?

    enum CodingKeys: String, CodingKey {
        case iconPrefix = "prefix"
        case suffix
    }
}

enum Suffix: String, Codable {
    case png = ".png"
}

// MARK: - Location
struct Location: Codable {
    let address, crossStreet: String?
    let lat, lng: Double?
    let distance: Int?
    let postalCode: String?
    let neighborhood: String?
    let city: String?
    let state: String?
    let country: String?
    let formattedAddress: [String]?
}
