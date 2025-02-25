//
//  MockNetworkService.swift
//  weatherTests
//
//  Created by mohamad ghonem on 24/02/2025.
//

import Foundation
@testable import weather
import Alamofire
import RxSwift
import RxCocoa

class MockHomeNetworkService: NetworkServiceProtocol {
    var mockWeatherResponse: WeatherResponseModel?
    var mockSearchResponse: [SearchResponseModelElement]?
    var shouldReturnError = false

    func fetchData<T: Decodable>(from urlString: String,
                                 method: HTTPMethod,
                                 parameters: [String: Any]? = nil,
                                 headers: [String: String]? = nil,
                                 queryParams: [String: String]? = nil) -> Single<T> {
        if shouldReturnError {
            return Single<T>.error(APIError.requestFailed)
        }

        if let response = mockWeatherResponse as? T {
            return Single<T>.just(response)
        }

        if let response = mockSearchResponse as? T {
            return Single<T>.just(response)
        }

        return Single<T>.error(APIError.decodingError)
    }
}
