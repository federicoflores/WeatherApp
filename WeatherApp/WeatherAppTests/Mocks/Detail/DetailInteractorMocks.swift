//
//  DetailInteractorMocks.swift
//  WeatherAppTests
//
//  Created by Fede Flores on 03/03/2024.
//

import Foundation
@testable import WeatherApp

class DetailInteractorMocks: DetailInteractorProtocols {
    
    var numberOfTimesRetrieveCurrencyWeatherWasCalled = 0
    var numberOfTimesRetrieveCurrencyWeatherIconWasCalled = 0
    
    var provider: WeatherApp.NetworkProviderProtocol = NetworkProviderStub()
    
    func retrieveCurrentWeather(latitude: String, longitude: String) {
        numberOfTimesRetrieveCurrencyWeatherWasCalled += 1
    }
    
    func retrieveCurrentWeatherIcon(with code: String) {
        numberOfTimesRetrieveCurrencyWeatherIconWasCalled += 1
    }
    
}


