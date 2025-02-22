//
//  ProfileVM.swift
//  Weather
//
//  Created by mohamad ghonem on 17/02/2025.
//

import Foundation
import RxRelay
import RxSwift

class FavoritesVM: BaseViewModel{
    
    private let bag = DisposeBag()
    var favouritesList = BehaviorSubject<[FavouriteModel]>(value: [])
    
    override init() {
        super.init()
        
        let arr = getStringArrayFromUserDefaults(name: .favorityCityArray)
        
        for item in arr ?? [] {
            fetchWeatherData(location: item)
        }
    }
    
    ///fetches the weather Response Data
    func fetchWeatherData(location: String){
        let urlString = "http://api.weatherapi.com/v1/current.json"
        
        let queryParams: [String: String] = [
            "key": "5ad74232f593458f8ce142136251702",
            "q": "\(location)",
            "aqi": "no"
        ]
        
        NetworkManager.shared.fetchData(from: urlString, method: .get, queryParams: queryParams)
            .subscribe(onSuccess: { [weak self] (favouriteResponse: FavoriteResponseModel) in
                self?.parseFavouriteResponse(favouriteResponse: favouriteResponse)
            }, onFailure: { [weak self] apiError in
//                self?.favouritesList.onNext([])
            })
            .disposed(by: bag)
    }
    
    private
    func parseFavouriteResponse(favouriteResponse: FavoriteResponseModel) {
        var favs = try? self.favouritesList.value()
        favs?.append(FavouriteModel(from: favouriteResponse))
        
        print(favs ?? [])
        self.favouritesList.onNext(favs ?? [])
        
        addCountryToFavouriteArray(location: favouriteResponse.location?.name ?? "")
    }
    
    private
    func addCountryToFavouriteArray(location: String){
        var arr = self.getStringArrayFromUserDefaults(name: .favorityCityArray)
        
        //checks if this location is already in favourites
        if (arr?.contains(location) ?? false){return}
        
        arr?.append(location)
        print(arr ?? [])
        self.saveStringArrayToUserDefaults(value: arr ?? [], name: .favorityCityArray)
    }

    
}
