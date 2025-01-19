//
//  MapPointer Model.swift
//  maps
//
//  Created by mohamad ghonem on 19/01/2025.
//

import Foundation

// MARK: - Venue
struct MapPointerModel: Codable {
    let name: String?
    let lat, lng: Double?
    let address: String?
    let categories: String?
}
