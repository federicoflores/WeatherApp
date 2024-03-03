//
//  JSONLoader.swift
//  WeatherAppTests
//
//  Created by Fede Flores on 03/03/2024.
//

import Foundation
@testable import WeatherApp

class JSONLoader {
    
    private enum MockedResponses: String {
        case currentWeather = "currentWeather"
    }
    
    func currentWeatherResponse() -> CurrentWeatherResponse? {
        if let path = Bundle.main.path(forResource: MockedResponses.currentWeather.rawValue, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let item = try? JSONDecoder().decode(CurrentWeatherResponse.self, from: data)
                return item
            } catch {
                print(error)
            }
        }
        return nil
    }
}

