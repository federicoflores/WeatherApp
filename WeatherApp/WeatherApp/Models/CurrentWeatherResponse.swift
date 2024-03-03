//
//  CurrentWeatherResponse.swift
//  WeatherApp
//
//  Created by Fede Flores on 02/03/2024.
//

import Foundation

struct CurrentWeatherResponse: Decodable {
    let id: Int
    let name: String
    let weather: [WeatherInfo]
    let main: MainInfo
    let wind: WindInfo
}


struct WeatherInfo: Decodable {
    let id: Int
    let icon: String
    let description: String
}

struct MainInfo: Decodable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct WindInfo: Decodable {
    let speed: Double
    let deg: Int
}
