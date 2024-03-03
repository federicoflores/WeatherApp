//
//  DetailPresenter.swift
//  WeatherApp
//
//  Created by Fede Flores on 02/03/2024.
//

import Foundation

protocol DetailPresenterProtocols: AnyObject {
    func fetchCurrentWeather()
    func onFetchCurrentWeatherSuccess(response: CurrentWeatherResponse)
    func onFetchCurrentWeatherFail(error: String)
    func onFetchWeatherIconSuccess(iconData: Data)
}

class DetailPresenter: DetailPresenterProtocols {
    
    weak var detailView: DetailViewProtocols?
    var detailInteractor: DetailInteractorProtocols?
    var detailRouter: DetailRouterProtocols?
    
    private var response: CurrentWeatherResponse? {
        didSet {
            if let icon = response?.weather.first?.icon {
                detailInteractor?.retrieveCurrentWeatherIcon(with: icon)
            }
        }
    }
    
    func fetchCurrentWeather() {
        detailView?.showLoadingView()
        detailInteractor?.retrieveCurrentWeather(latitude: "34.0194704", longitude: "-118.4912273")
    }
    
    func onFetchCurrentWeatherSuccess(response: CurrentWeatherResponse) {
        self.response = response
    }
    
    func onFetchCurrentWeatherFail(error: String) {
        detailView?.hideLoadingView()
        detailView?.setEmptyStateSubtitle(subtitle: error)
        detailView?.isEmptyStateHidden(isHidden: false)
    }
    
    func onFetchWeatherIconSuccess(iconData: Data) {
        detailView?.isEmptyStateHidden(isHidden: true)
        detailView?.hideLoadingView()
        detailView?.setWeatherIcon(with: iconData)
        detailView?.setWeatherInfo(
            place: response?.name ?? "",
            mainTemp: "\(Int(response?.main.temp ?? 0))",
            weatherDescription: "\(response?.weather.first?.description ?? "")",
            minTemp: "\(Int(response?.main.tempMin ?? 0))",
            maxTemp: "\(Int(response?.main.tempMax ?? 0))",
            windSpeed: "\(response?.wind.speed ?? 0)",
            windDeg: "\(response?.wind.deg ?? 0)")
    }
    
}
