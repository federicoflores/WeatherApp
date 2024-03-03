//
//  DetailPresenterMocks.swift
//  WeatherAppTests
//
//  Created by Fede Flores on 03/03/2024.
//

import Foundation
@testable import WeatherApp

class DetailPresenterMocks: DetailPresenterProtocols {
    
    var numberOfTimesFetchCurrentWeatherCalled = 0
    var numberOfTimesOnFetchCurrentWeatherSuccessCalled = 0
    var numberOfTimesOnFetchCurrentWeatherFailCalled = 0
    var numberOfTimesOnFetchWeatherIconSuccessCalled = 0
    
    func fetchCurrentWeather() {
        numberOfTimesFetchCurrentWeatherCalled += 1
    }
    
    func onFetchCurrentWeatherSuccess(response: WeatherApp.CurrentWeatherResponse) {
        numberOfTimesOnFetchCurrentWeatherSuccessCalled += 1
    }
    
    func onFetchCurrentWeatherFail(error: String) {
        numberOfTimesOnFetchCurrentWeatherFailCalled += 1
    }
    
    func onFetchWeatherIconSuccess(iconData: Data) {
        numberOfTimesOnFetchWeatherIconSuccessCalled += 1
    }
    
    
}
