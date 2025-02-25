//
//  HomeVMTests.swift
//  weatherTests
//
//  Created by mohamad ghonem on 24/02/2025.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import weather


final class HomeVMTests: XCTestCase {
    
    var viewModel: HomeVM!
    var mockNetworkService: MockHomeNetworkService!
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!
    var observer: TestableObserver<[ForecastModel]>!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockHomeNetworkService()
        viewModel = HomeVM(networkService: mockNetworkService)
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        observer = scheduler.createObserver([ForecastModel].self)
        
        viewModel.weatherforecast
            .subscribe(observer)
            .disposed(by: disposeBag)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        disposeBag = nil
        super.tearDown()
    }
    
    //Test Case 1: Fetch Weather Data (Success)
    func testFetchWeatherData_Success() {
        // Given: Mock Weather Data
        let mockWeatherResponse = WeatherResponseModel(
            current: Current(lastUpdated: "2024-02-22 14:00", tempC: 20.0, tempF: 68.0, isDay: 1,
                             condition: Condition(text: "Sunny", icon: "//cdn.weather.com/icon.png"),
                             windMph: 10.0, windKph: 16.0, windDegree: 180, windDir: "S", humidity: 60.0),
            forecast: Forecast(forecastday: [
                Forecastday(date: "2024-02-23", day: Day(avgtempC: 22.0, avgtempF: 71.6,
                                                         maxwindMph: 12.0, maxwindKph: 19.3, avghumidity: 65.0,
                                                         condition: Condition(text: "Cloudy", icon: "//cdn.weather.com/cloudy.png")))
            ])
        )
        
        mockNetworkService.mockWeatherResponse = mockWeatherResponse
        
        // When: Fetching Weather Data
        viewModel.fetchWeatherData(location: "London")
        
        // Then: Assert Expected Results
        let expectedForecasts = [
            ForecastModel(from: mockWeatherResponse.forecast!.forecastday![0])
        ]
        
        XCTAssertEqual(observer.events.last?.value.element, expectedForecasts)
    }
    
    //Test Case 2: Fetch Weather Data (Failure)
    func testFetchWeatherData_Failure() {
        mockNetworkService.shouldReturnError = true

        viewModel.fetchWeatherData(location: "London")

        XCTAssertEqual(observer.events.first?.value.element, [])  // Should emit an empty array on failure
    }
    
    //Test Case 3: Fetch Search Data (Success)
    func testFetchSearchData_Success() {
        let mockSearchResults = [
            SearchResponseModelElement(id: 1, name: "London", region: "England", country: "UK", lat: 51.5074, lon: -0.1278, url: "https://london.com")
        ]
        mockNetworkService.mockSearchResponse = mockSearchResults  // ✅ Assign mock response
        mockNetworkService.mockSearchResponse = mockSearchResults  // ✅ Assign mock response

        let observer = scheduler.createObserver([SearchResponseModelElement].self)
        viewModel.searchArray.subscribe(observer).disposed(by: disposeBag)

        viewModel.fetchSearchData(search: "Lond")  // ✅ Trigger the API call

        scheduler.start()  // ✅ Ensure RxSwift observable emits events

        let expected = [
            SearchResponseModelElement(id: 1, name: "London", region: "England", country: "UK", lat: 51.5074, lon: -0.1278, url: "https://london.com")
        ]

        XCTAssertEqual(observer.events.last?.value.element, expected)
    }



    //Test Case 4: Fetch Search Data (Empty)
    func testFetchSearchData_EmptyQuery() {
        viewModel.fetchSearchData(search: "")

        XCTAssertEqual(observer.events.first?.value.element, []) // Should return empty array when search is empty
    }


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
