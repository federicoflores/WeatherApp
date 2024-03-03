//
//  DetailViewMocks.swift
//  WeatherAppTests
//
//  Created by Fede Flores on 03/03/2024.
//

import Foundation
@testable import WeatherApp

class DetailViewMocks: DetailViewProtocols {
    
    var numberOfTimesShowLoadingViewCalled = 0
    var numberOfTimesHideLoadingViewCalled = 0
    var numberOfTimesSetWeatherInfoCalled = 0
    var numberOfTimesSetWeatherIconCalled = 0
    var numberOfTimesIsEmptyStateHiddenCalled = 0
    var numberOfTimesSetEmptyStateSubtitleCalled = 0
    
    func showLoadingView() {
        numberOfTimesShowLoadingViewCalled += 1
    }
    
    func hideLoadingView() {
        numberOfTimesHideLoadingViewCalled += 1
    }
    
    func setWeatherInfo(place: String, mainTemp: String, weatherDescription: String, minTemp: String, maxTemp: String, windSpeed: String, windDeg: String) {
        numberOfTimesSetWeatherInfoCalled += 1
    }
    
    func setWeatherIcon(with imageData: Data) {
        numberOfTimesSetWeatherIconCalled += 1
    }
    
    func isEmptyStateHidden(isHidden: Bool) {
        numberOfTimesIsEmptyStateHiddenCalled += 1
    }
    
    func setEmptyStateSubtitle(subtitle: String) {
        numberOfTimesSetEmptyStateSubtitleCalled += 1
    }
}
