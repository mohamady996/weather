//
//  FavouritesVMTests.swift
//  weatherTests
//
//  Created by mohamad ghonem on 25/02/2025.
//

import XCTest
import RxSwift
import RxTest
@testable import weather

class FavoritesVMTests: XCTestCase {
    
    var viewModel: FavoritesVM!
    var mockNetworkService: MockFavouritesNetworkService!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockFavouritesNetworkService()
        viewModel = FavoritesVM(networkService: mockNetworkService)
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        scheduler = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func testInitialLoad_fetchesStoredFavorites() {
        // Given
        UserDefaults.standard.set(["Paris", "London"], forKey: "favorityCityArray")

        // When
        let viewModel = FavoritesVM(networkService: mockNetworkService)
        
        // Then
        XCTAssertEqual(mockNetworkService.fetchWeatherCallCount, 2)
    }

    func testFetchWeatherData_Success() {
        // Given
        let observer = scheduler.createObserver([FavouriteModel].self)
        viewModel.favouritesList.subscribe(observer).disposed(by: disposeBag)

        let mockFavoriteLocation = FavoriteLocation(name: "London")
        let mockFavouriteCurrent = FavoriteCurrent(lastUpdated: "2024-02-22 14:00", tempC: 20.0, tempF: 68.0, condition: FavoriteCondition(text: "Sunny", icon: "//cdn.weather.com/icon.png"), windMph: 10.0, windKph: 16.0, windDegree: 180, windDir: "S", humidity: 60)
        let mockFavoriteResponseModel = FavoriteResponseModel(location: mockFavoriteLocation, current: mockFavouriteCurrent)

        mockNetworkService.mockWeatherResponse = mockFavoriteResponseModel

        // When
        viewModel.fetchWeatherData(location: "London")

        // Then
        scheduler.start()
        XCTAssertEqual(observer.events.last?.value.element?.first?.location, "London")
    }

    func testRemoveFavourite_Success() {
        // Given
        let observer = scheduler.createObserver([FavouriteModel].self)
        viewModel.favouritesList.subscribe(observer).disposed(by: disposeBag)

        
        let mockFavoriteLocation = FavoriteLocation(name: "London")
        let mockFavouriteCurrent = FavoriteCurrent(lastUpdated: "2024-02-22 14:00", tempC: 20.0, tempF: 68.0, condition: FavoriteCondition(text: "Sunny", icon: "//cdn.weather.com/icon.png"), windMph: 10.0, windKph: 16.0, windDegree: 180, windDir: "S", humidity: 60)
        let mockFavoriteResponseModel = FavoriteResponseModel(location: mockFavoriteLocation, current: mockFavouriteCurrent)
        let mockFavoriteModel = FavouriteModel(from: mockFavoriteResponseModel)
        
        let initialFavorites = [mockFavoriteModel]
        viewModel.favouritesList.onNext(initialFavorites)

        // When
        viewModel.removeFavourite(at: 0)

        // Then
        scheduler.start()
        XCTAssertEqual(observer.events.last?.value.element?.count, 0)
    }
}
