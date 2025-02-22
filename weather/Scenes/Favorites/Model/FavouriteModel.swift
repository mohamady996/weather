//
//  FavouriteModel.swift
//  weather
//
//  Created by mohamad ghonem on 22/02/2025.
//

import Foundation


struct FavouriteModel{
    let location: String?
    let date: String?
    let tempC, tempF: Double?
    let condition: String?
    let conditionIconURL: String?
    let windKph: Double?
    let humidity: Int?
    
    init(from model: FavoriteResponseModel){
        location = model.location?.name
        date = convertDateFormater(date: model.current?.lastUpdated ?? "", from: "yyyy-MM-dd HH:mm" )
        tempC = model.current?.tempC
        tempF = model.current?.tempF
        condition = model.current?.condition?.text
        windKph = model.current?.windKph
        humidity = model.current?.humidity
        conditionIconURL = "https:\(model.current?.condition?.icon ?? "")"
    }
}

private func convertDateFormater(date: String, from format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.timeZone = NSTimeZone(name: "UTC") as? TimeZone

    guard let date = dateFormatter.date(from: date) else {
        assert(false, "no date from string")
        return ""
    }
    
    dateFormatter.dateFormat = "yyyy MMM dd"
    dateFormatter.timeZone = NSTimeZone(name: "UTC") as? TimeZone
    let timeStamp = dateFormatter.string(from: date)

    return timeStamp
}
