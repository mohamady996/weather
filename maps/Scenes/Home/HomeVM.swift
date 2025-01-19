//
//  HomeVM.swift
//  maps
//
//  Created by mohamad ghonem on 19/01/2025.
//

import Foundation
import Alamofire
import CoreLocation
import RxSwift

class HomeVM: BaseViewModel {
    
    var mapPointers = BehaviorSubject<[MapPointerModel]>(value: [])
    
    override init() {
        super.init()
        self.fetchMapData()
    }
    
    private
    func fetchMapData(){
        
        let coordinates = getCurrentCoordinates()
        
        let url = "https://api.foursquare.com/v2/venues/search?ll=\(coordinates)&client_id=4EQRZPSGKBZGFSERGJY055FRW2OSPJRZYR4C3J0JN2CQQFIV&client_secret=AJR4B5LLRONWAJWJJOACHAFLCWS2YJAZMGQNFFZQP0IB3THR&v=20180910"
        AF.request(url, method: .get)
            .validate() // Validates the response status code and content type
            .responseDecodable(of: MapResponseModel.self) { response in
                switch response.result {
                case .success(let mapsResponse):
                    self.handleMapsResponse(mapsResponse: mapsResponse)
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
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
    func handleMapsResponse(mapsResponse: MapResponseModel){
        //checks if transaction successfull
        guard mapsResponse.meta?.code == 200 else {
            return
        }

        var pointers: [MapPointerModel] = []

        for venue in mapsResponse.response?.venues?.compactMap(\.self) ?? []{
            var categories = ""
            var address = ""
            for item in venue.location?.formattedAddress?.compactMap(\.self) ?? []{
                address.append("\(item),")
            }
            if !address.isEmpty{
                address.removeLast()
                address.append(".")
            }
            
            for item in venue.categories?.compactMap(\.self) ?? []{
                categories.append("\(item.name ?? ""),")
            }
            if !categories.isEmpty{
                categories.removeLast()
                categories.append(".")
            }
            
            if let name = venue.name,
               let lat = venue.location?.lat,
               let lang = venue.location?.lng{
                
                pointers.append(MapPointerModel(name: name, lat: lat, lng: lang, address: address, categories: categories))
            }
        }
        mapPointers.onNext(pointers)
    }
}
