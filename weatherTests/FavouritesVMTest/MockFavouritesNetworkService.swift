//
//  MockFavouritesNetworkService.swift
//  weatherTests
//
//  Created by mohamad ghonem on 25/02/2025.
//

import Foundation
@testable import weather
import Alamofire
import RxSwift
import RxCocoa

class MockFavouritesNetworkService: NetworkServiceProtocol {
    var mockWeatherResponse: FavoriteResponseModel?
    var shouldReturnError = false
    var fetchWeatherCallCount = 0

    func fetchData<T: Decodable>(from urlString: String,
                                 method: HTTPMethod,
                                 parameters: [String: Any]? = nil,
                                 headers: [String: String]? = nil,
                                 queryParams: [String: String]? = nil) -> Single<T> {
        fetchWeatherCallCount += 1

        if shouldReturnError {
            return Single<T>.error(APIError.requestFailed)
        }

        if let response = mockWeatherResponse as? T {
            return Single<T>.just(response)
        }

        return Single<T>.error(APIError.decodingError)
    }
}
