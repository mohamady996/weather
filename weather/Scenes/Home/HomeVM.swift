//
//  HomeVM.swift
//  Weather
//
//  Created by mohamad ghonem on 17/02/2025.
//

import Foundation
import Alamofire
import CoreLocation
import RxSwift

class HomeVM: BaseViewModel {
    
    var weatherforecast = BehaviorSubject<[ForecastModel]>(value: [])
    var searchArray = BehaviorSubject<[SearchResponseModelElement]>(value: [])

    private let bag = DisposeBag()

        
    override init() {
        super.init()
        
        //checks if a default city is set or not,
        // if not then get current coordinates
        if let defaultCity = getStringFromUserDefaults(name: .defaultCity), defaultCity != ""{
            self.fetchWeatherData(location: defaultCity)
        } else{
            self.fetchWeatherData(location: self.getCurrentCoordinates())
        }
    
        checkTemperatureUnitPreference()
    }
    
    func pulledToRefreshAction(){
        if let defaultCity = getStringFromUserDefaults(name: .defaultCity), defaultCity != ""{
            self.fetchWeatherData(location: defaultCity)
        } else{
            self.fetchWeatherData(location: self.getCurrentCoordinates())
        }
    }
    
    ///fetches the weather Response Data
    func fetchWeatherData(location: String){
        let urlString = "http://api.weatherapi.com/v1/forecast.json?key=5ad74232f593458f8ce142136251702&q=\(location)&days=7&aqi=no&alerts=no"
        
        NetworkManager.shared.fetchData(from: urlString, method: .get)
            .subscribe(onSuccess: { [weak self] (weatherResponse: WeatherResponseModel) in
                var weatherArray: [ForecastModel] = []
                //Todays weather
//                guard let current = weatherResponse.current else { return }
//                weatherArray.append(ForecastModel(from: current ))

                //The next 7 days
                guard let forecasts = weatherResponse.forecast?.forecastday else { return }
                
                for forecast in forecasts{
                    weatherArray.append(ForecastModel(from: forecast ))
                }
                
                self?.weatherforecast.onNext(weatherArray)
            }, onFailure: { [weak self] apiError in
                self?.weatherforecast.onNext([])
            })
            .disposed(by: bag)
    }
    
    ///searches for cities with similar names
    func fetchSearchData(search: String){
        if search == ""{
            self.searchArray.onNext([])
            return
        }
        
        let urlString = "http://api.weatherapi.com/v1/search.json?key=5ad74232f593458f8ce142136251702&q=\(search)"
        
        NetworkManager.shared.fetchData(from: urlString, method: .get)
            .subscribe(onSuccess: { [weak self] (searchResponse: [SearchResponseModelElement]) in
                self?.searchArray.onNext(searchResponse)
            }, onFailure: { [weak self] apiError in
                self?.searchArray.onNext([])
            })
            .disposed(by: bag)
    }
    
    private
    func getCurrentCoordinates() -> String{
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        
        var currentLocation: CLLocation!

        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
           CLLocationManager.authorizationStatus() ==  .authorizedAlways) {
            currentLocation = locManager.location
            print( "\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)")
            return "\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)"
        }
        
        return ""
    }
    
    private
    func checkTemperatureUnitPreference(){
        if getBoolFromUserDefaults(name: .tempAsCelcius) == nil{
            saveBoolToUserDefaults(value: true, name: .tempAsCelcius)
        }
    }
}
