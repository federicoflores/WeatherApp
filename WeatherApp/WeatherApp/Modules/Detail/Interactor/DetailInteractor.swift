//
//  DetailInteractor.swift
//  WeatherApp
//
//  Created by Fede Flores on 02/03/2024.
//

import UIKit

protocol DetailInteractorProtocols: AnyObject {
    var provider: NetworkProviderProtocol { get }
    func retrieveCurrentWeather(latitude: String, longitude: String)
    func retrieveCurrentWeatherIcon(with code: String)
    
}

class DetailInteractor: DetailInteractorProtocols {
    
    weak var detailPresenter: DetailPresenterProtocols?
    
    var provider: NetworkProviderProtocol
    
    init(provider: NetworkProviderProtocol) {
        self.provider = provider
    }
    
    func retrieveCurrentWeather(latitude: String, longitude: String) {
        provider.getDecodable(path: .weatherData, query: .weatherData(latitude: latitude, longitude: longitude)) { [weak self] (result: Result<CurrentWeatherResponse, Error>) in
            switch result {
            case .success(let response):
                self?.detailPresenter?.onFetchCurrentWeatherSuccess(response: response)
            case .failure(let error):
                self?.detailPresenter?.onFetchCurrentWeatherFail(error: error.localizedDescription)
            }
        }
    }
    
    func retrieveCurrentWeatherIcon(with code: String) {
        provider.getData(path: .weatherIcon(iconCode: code), query: .weatherIcon) { [weak self] (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                self?.detailPresenter?.onFetchWeatherIconSuccess(iconData: data)
            case .failure(let error):
                self?.detailPresenter?.onFetchCurrentWeatherFail(error: error.localizedDescription)
            }
        }
    }
}
