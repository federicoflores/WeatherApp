//
//  NetworkProviderStub.swift
//  WeatherAppTests
//
//  Created by Fede Flores on 03/03/2024.
//

import UIKit
@testable import WeatherApp

class NetworkProviderStub: NetworkProviderProtocol {
    func getDecodable<T>(path: WeatherApp.NetworkProvider.Path, query: WeatherApp.NetworkProvider.QueryFields, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        switch path {
        case .weatherData:
            completion(.success(JSONLoader().currentWeatherResponse() as! T))
        case .weatherIcon(iconCode: _):
            completion(.failure(NSError(domain: "Test error. Failure case", code: 404)))
        }
    }
    
    func getData(path: WeatherApp.NetworkProvider.Path, query: WeatherApp.NetworkProvider.QueryFields, completion: @escaping (Result<Data, Error>) -> Void) {
        switch path {
        case .weatherData:
            completion(.failure(NSError(domain: "Test error. Failure case", code: 404)))
        case .weatherIcon(iconCode: _):
            guard let imageData = UIImage(systemName: "heart.fill")?.pngData() else {
                completion(.failure(NSError(domain: "Test error. Unable to convert UIImage to Data", code: 404)))
                return
            }
            completion(.success(imageData))
        }
    }
    
    
}
