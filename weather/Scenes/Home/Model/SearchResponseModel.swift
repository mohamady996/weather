//
//  SearchResponseModel.swift
//  weather
//
//  Created by mohamad ghonem on 21/02/2025.
//

import Foundation

// MARK: - SearchResponseModelElement
struct SearchResponseModelElement: Codable {
    let id: Int?
    let name, region, country: String?
    let lat, lon: Double?
    let url: String?
}

typealias SearchResponseModel = [SearchResponseModelElement]
