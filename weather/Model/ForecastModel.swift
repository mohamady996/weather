//
//  forecastModel.swift
//  weather
//
//  Created by mohamad ghonem on 18/02/2025.
//

import Foundation

struct ForecastModel{
    let date: String?
    let tempC, tempF: Double?
    let condition: String?
    let conditionIconURL: String?
    let windKph: Double?
    let humidity: Int?
    
    init(from model: Current){
        date = convertDateFormater(date: model.lastUpdated ?? "", from: "yyyy-MM-dd HH:mm" )
        tempC = model.tempC
        tempF = model.tempF
        condition = model.condition?.text
        windKph = model.windKph
        humidity = model.humidity
        conditionIconURL = "https:\(model.condition?.icon ?? "")"
    }
    
    init(from model: Forecastday){
        date = convertDateFormater(date: model.date ?? "", from: "yyyy-MM-dd" )
        tempC = model.day?.avgtempC
        tempF = model.day?.avgtempF
        condition = model.day?.condition?.text
        windKph = model.day?.maxwindKph
        humidity = model.day?.avghumidity
        conditionIconURL = "https:\(model.day?.condition?.icon ?? "")"
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
