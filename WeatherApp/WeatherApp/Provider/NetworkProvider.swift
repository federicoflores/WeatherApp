//
//  NetworkProvider.swift
//  WeatherApp
//
//  Created by Fede Flores on 02/03/2024.
//

import Foundation
import Combine

protocol NetworkProviderProtocol {
    func getDecodable<T: Decodable>(path: NetworkProvider.Path, query: NetworkProvider.QueryFields, completion: @escaping (Result<T, Error>) -> Void)
    func getData(path: NetworkProvider.Path, query: NetworkProvider.QueryFields, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkProvider: NetworkProviderProtocol {
    
    fileprivate enum Constant {
        static let sesionConfigTimeIntervals: CGFloat = 20.0
        static let latitudeKey: String = "lat"
        static let longitudeKey: String = "lon"
        static let apiIDKey: String = "appid"
        static let scheme: String = "https"
    }
    
    init() {
        sessionConfig.timeoutIntervalForRequest = Constant.sesionConfigTimeIntervals
        sessionConfig.timeoutIntervalForResource = Constant.sesionConfigTimeIntervals
    }
    
    enum Path {
        case weatherData
        case weatherIcon(iconCode: String)
        
        func setPath() -> String {
            switch self {
            case .weatherData:
                return "/data/2.5/weather"
            case .weatherIcon(let iconCode):
                return "/img/wn/\(iconCode)@2x.png"
            }
        }
    }
    
    enum QueryFields {
        case weatherData(latitude: String, longitude: String)
        case weatherIcon
        
        func setQuery()->  [URLQueryItem] {
            var queryItems: [URLQueryItem] = [URLQueryItem(name: Constant.apiIDKey, value: AppConfigurationManager.shared.getAppConfiguration(with: .API_ID))]
            switch self {
            case .weatherData(let latitude, let longitude):
                queryItems.append(URLQueryItem(name: Constant.latitudeKey, value: latitude))
                queryItems.append(URLQueryItem(name: Constant.longitudeKey, value: longitude))
            case .weatherIcon:
                break
            }
            return queryItems
        }
    }
    
    private var cancellable = Set<AnyCancellable>()
    let sessionConfig = URLSessionConfiguration.default
    let cacheManager = CacheManager.shared.cache
    
    func getDecodable<T: Decodable>(path: Path, query: QueryFields, completion: @escaping (Result<T, Error>) -> Void) {
        
        let queryItems = query.setQuery()
        
        var components = URLComponents()
        components.scheme = Constant.scheme
        components.host = "api.openweathermap.org"
        components.path = path.setPath()
        
        components.queryItems = queryItems
        
        guard let url = components.url else { return }
        
        if let cached = cacheManager[url.absoluteString as NSString], let decodable = cached as? T {
            completion(.success(decodable))
            return
        }
                
        let request = URLRequest(url: url)
        
        URLSession(configuration: sessionConfig)
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .sink { resultCompletion in
                switch resultCompletion {
                case .finished:
                    return
                case .failure(let error):
                    completion(.failure(error))
                }
            } receiveValue: {  value in
                self.cacheManager[url.absoluteString as NSString] = value
                completion(.success(value))
            }
            .store(in: &cancellable)
    }
    
    func getData(path: Path, query: QueryFields, completion: @escaping (Result<Data, Error>) -> Void) {
        
        var components = URLComponents()
        components.scheme = Constant.scheme
        components.host = "openweathermap.org"
        components.path = path.setPath()
        components.queryItems = query.setQuery()
        
        guard let url = components.url else { return }
        
        if let cached = cacheManager[url.absoluteString as NSString], let data = cached as? Data {
            completion(.success(data))
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession(configuration: sessionConfig)
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .sink { resultCompletion in
                switch resultCompletion {
                case .finished:
                    return
                case .failure(let error):
                    completion(.failure(error))
                }
            } receiveValue: { value in
                self.cacheManager[url.absoluteString as NSString] = value
                completion(.success(value))
            }
            .store(in: &cancellable)
    }
    
}
