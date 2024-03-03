//
//  DetailPresenterTests.swift
//  WeatherAppTests
//
//  Created by Fede Flores on 03/03/2024.
//

import XCTest
@testable import WeatherApp

final class DetailPresenterTests: XCTestCase {

    var sut: DetailPresenter?
    var view: DetailViewMocks?
    var interactor: DetailInteractorMocks?
    var router: DetailRouterMocks?

    override func setUpWithError() throws {
        sut = DetailPresenter()
        view = DetailViewMocks()
        router = DetailRouterMocks()
        interactor = DetailInteractorMocks()
        
        sut?.detailInteractor = interactor
        sut?.detailRouter = router
        sut?.detailView = view
    }

    override func tearDownWithError() throws {
        sut = nil
        view = nil
        router = nil
        interactor = nil
    }
    
    func testfetchCurrentWeather() {
        sut?.fetchCurrentWeather()
        XCTAssertEqual(view?.numberOfTimesShowLoadingViewCalled, 1)
        XCTAssertEqual(interactor?.numberOfTimesRetrieveCurrencyWeatherWasCalled, 1)
        XCTAssertNotEqual(view?.numberOfTimesShowLoadingViewCalled, 2)
        XCTAssertNotEqual(interactor?.numberOfTimesRetrieveCurrencyWeatherWasCalled, 2)
    }
    
    func testOnFetchCurrentWeatherSuccess() throws {
        let response = try XCTUnwrap(JSONLoader().currentWeatherResponse())
        sut?.onFetchCurrentWeatherSuccess(response: response)
        XCTAssertEqual(interactor?.numberOfTimesRetrieveCurrencyWeatherIconWasCalled, 1)
        XCTAssertNotEqual(interactor?.numberOfTimesRetrieveCurrencyWeatherIconWasCalled, 0)
    }
    
    func testOnFetchCurrentWeatherFails() {
        sut?.onFetchCurrentWeatherFail(error: "testError")
        XCTAssertEqual(view?.numberOfTimesHideLoadingViewCalled, 1)
        XCTAssertEqual(view?.numberOfTimesSetEmptyStateSubtitleCalled, 1)
        XCTAssertEqual(view?.numberOfTimesIsEmptyStateHiddenCalled, 1)
        
        XCTAssertNotEqual(view?.numberOfTimesHideLoadingViewCalled, 0)
        XCTAssertNotEqual(view?.numberOfTimesSetEmptyStateSubtitleCalled, 0)
        XCTAssertNotEqual(view?.numberOfTimesIsEmptyStateHiddenCalled, 0)
    }
    
    func testOnFetchWeatherIconSuccess() {
        sut?.onFetchWeatherIconSuccess(iconData: Data())
        XCTAssertEqual(view?.numberOfTimesIsEmptyStateHiddenCalled, 1)
        XCTAssertEqual(view?.numberOfTimesHideLoadingViewCalled, 1)
        XCTAssertEqual(view?.numberOfTimesSetWeatherIconCalled, 1)
        XCTAssertEqual(view?.numberOfTimesSetWeatherInfoCalled, 1)
        
        XCTAssertNotEqual(view?.numberOfTimesIsEmptyStateHiddenCalled, 2)
        XCTAssertNotEqual(view?.numberOfTimesHideLoadingViewCalled, 2)
        XCTAssertNotEqual(view?.numberOfTimesSetWeatherIconCalled, 0)
        XCTAssertNotEqual(view?.numberOfTimesSetWeatherInfoCalled, 0)
    }
}

