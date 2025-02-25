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
    
    private let networkService: NetworkServiceProtocol

    
    init(networkService: NetworkServiceProtocol = NetworkManager.shared) {
        self.networkService = networkService
        super.init()
        
        let arr = getStringArrayFromUserDefaults(name: .favorityCityArray)
        print(arr)
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
        
        networkService.fetchData(from: urlString,
                                         method: .get,
                                         parameters: nil,
                                         headers: nil,
                                         queryParams: queryParams)
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
        
        self.favouritesList.onNext(favs ?? [])
        
        addCountryToFavouriteArray(location: favouriteResponse.location?.name ?? "")
    }
    
    private
    func addCountryToFavouriteArray(location: String){
        var arr = self.getStringArrayFromUserDefaults(name: .favorityCityArray)
        
        //checks if this location is already in favourites
        if (arr?.contains(location) ?? false){return}
        
        arr?.append(location)
        self.saveStringArrayToUserDefaults(value: arr ?? [], name: .favorityCityArray)
    }
    
    ///removes this item from the favourites list
    func removeFavourite(at index: Int){
        //removes the item from the tableview
        var list = try? favouritesList.value()
        
        let location = list?.remove(at: index).location ?? ""
        favouritesList.onNext(list ?? [])
        
        
        //removes the item from the favourites list
        var arr = self.getStringArrayFromUserDefaults(name: .favorityCityArray)
        let index2 = arr?.firstIndex(of: (location)) ?? 0
        arr?.remove(at: index2 )
        self.saveStringArrayToUserDefaults(value: arr ?? [], name: .favorityCityArray)
        
    }

    
}
