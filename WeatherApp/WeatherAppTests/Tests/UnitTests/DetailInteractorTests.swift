//
//  DetailInteractorTests.swift
//  WeatherAppTests
//
//  Created by Fede Flores on 03/03/2024.
//

import XCTest
@testable import WeatherApp

final class DetailInteractorTests: XCTestCase {
    
    var presenter: DetailPresenterMocks?
    var sut: DetailInteractor?
    
    override func setUpWithError() throws {
        sut = DetailInteractor(provider: NetworkProviderStub())
        presenter = DetailPresenterMocks()
        
        sut?.detailPresenter = presenter
    }
    
    override func tearDownWithError() throws {
        sut = nil
        presenter = nil
    }
    
    func testRetrieveCurrentWeatherSuccess() {
        sut?.retrieveCurrentWeather(latitude: "", longitude: "")
        XCTAssertEqual(presenter?.numberOfTimesOnFetchCurrentWeatherSuccessCalled, 1)
    }
    
    func testRetrieveCurrentWeatherIconSuccess() {
        sut?.retrieveCurrentWeatherIcon(with: "")
        XCTAssertEqual(presenter?.numberOfTimesOnFetchWeatherIconSuccessCalled, 1)
    }
}
