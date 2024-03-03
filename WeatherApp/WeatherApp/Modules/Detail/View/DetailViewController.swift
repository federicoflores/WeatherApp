//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Fede Flores on 02/03/2024.
//

import UIKit

protocol DetailViewProtocols: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func setWeatherInfo(place: String, mainTemp: String, weatherDescription: String, minTemp: String, maxTemp: String, windSpeed: String, windDeg: String)
    func setWeatherIcon(with imageData: Data)
    func isEmptyStateHidden(isHidden: Bool)
    func setEmptyStateSubtitle(subtitle: String)
}

class DetailViewController: UIViewController {
    
    private enum Constants {
        static let placeLabelSize: CGFloat = 32
        static let mainTempLabel: CGFloat = 70
        static let weatherDescriptionLabelSize: CGFloat = 24
        static let minTempLabelSize: CGFloat = 24
        static let maxTempLabelSize: CGFloat = 24
        static let windSpeedLabelSize: CGFloat = 24
        static let windDegLabelSize: CGFloat = 24
        static let textColor: UIColor = UIColor.lightGray
        static let placeLabelTopPadding: CGFloat = 50
        static let weatherIconImageViewSize: CGFloat = 250
        static let weatherDescriptionLabelTopPadding: CGFloat = 20
        static let tempStackViewTopPadding: CGFloat = 20
        static let windStackViewTopPadding: CGFloat = 20
        static let windStackViewBottomPadding: CGFloat = 500
        static let backgroundColor: UIColor = UIColor.black
        static let navigationTitleTextColor: UIColor = UIColor.white
        static let gradeSymbol: String = "°"
        static let tempStackViewSpacing: CGFloat = 4
        static let windStackViewSpacing: CGFloat = 4
    }
    
    private enum Wording {
        static let title: String = "Weather app"
        static let minTempKey: String = "Low: "
        static let maxTempKey: String = "High: "
        static let windKey: String = "Wind: "
    }
    
    var detailPresenter: DetailPresenterProtocols?
    
    private let placeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.textColor
        label.font = .systemFont(ofSize: Constants.placeLabelSize)
        return label
    }()
    
    private let weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let mainTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.textColor
        label.font = .systemFont(ofSize: Constants.mainTempLabel, weight: .medium)
        return label
    }()
    
    private let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.textColor
        label.font = .systemFont(ofSize: Constants.weatherDescriptionLabelSize)
        return label
    }()
    
    private let minTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Constants.minTempLabelSize)
        label.textColor = Constants.textColor
        return label
    }()
    
    private let maxTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Constants.maxTempLabelSize)
        label.textColor = Constants.textColor
        return label
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.textColor
        label.font = .systemFont(ofSize: Constants.windSpeedLabelSize)
        return label
    }()
    
    private let windDegLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Constants.windDegLabelSize)
        label.textColor = Constants.textColor
        return label
    }()
    
    private let tempStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.spacing = Constants.tempStackViewSpacing
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let windStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = Constants.windStackViewSpacing
        return stackView
    }()
    
    private let emptyStateView = {
        let emptyState = EmptyStateView()
        emptyState.translatesAutoresizingMaskIntoConstraints = false
        return emptyState
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        setupViews()
        detailPresenter?.fetchCurrentWeather()
        
    }
    
    private func addSubview() {
        view.addSubview(placeLabel)
        view.addSubview(weatherIconImageView)
        view.addSubview(mainTempLabel)
        view.addSubview(weatherDescriptionLabel)
        view.addSubview(tempStackView)
        view.addSubview(windStackView)
        view.addSubview(emptyStateView)
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.backgroundColor
        title = Wording.title
        let textAttributes = [NSAttributedString.Key.foregroundColor: Constants.navigationTitleTextColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        
        //placeLabel
        
        placeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        placeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.placeLabelTopPadding).isActive = true
        
        //weatherIconImageView
        
        weatherIconImageView.heightAnchor.constraint(equalToConstant: Constants.weatherIconImageViewSize).isActive = true
        weatherIconImageView.widthAnchor.constraint(equalToConstant: Constants.weatherIconImageViewSize).isActive = true
        weatherIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherIconImageView.topAnchor.constraint(equalTo: placeLabel.bottomAnchor).isActive = true
        
        //mainTempLabel
        
        mainTempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainTempLabel.topAnchor.constraint(equalTo: weatherIconImageView.bottomAnchor).isActive = true
        
        
        //weatherDescriptionLabel
        
        weatherDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherDescriptionLabel.topAnchor.constraint(equalTo: mainTempLabel.bottomAnchor, constant: Constants.weatherDescriptionLabelTopPadding).isActive = true
        
        //tempStackView
        
        tempStackView.addArrangedSubview(minTempLabel)
        tempStackView.addArrangedSubview(maxTempLabel)
        
        tempStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tempStackView.topAnchor.constraint(equalTo: weatherDescriptionLabel.bottomAnchor, constant: Constants.tempStackViewTopPadding).isActive = true
        
        
        //windStackView
        
        windStackView.addArrangedSubview(windSpeedLabel)
        windStackView.addArrangedSubview(windDegLabel)
        windStackView.distribution = .equalSpacing
        windStackView.axis = .horizontal
        
        
        windStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        windStackView.topAnchor.constraint(equalTo: tempStackView.bottomAnchor, constant: Constants.windStackViewTopPadding).isActive = true
        windStackView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: -Constants.windStackViewBottomPadding).isActive = true
        
        //emptyStateView
        
        emptyStateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        emptyStateView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        emptyStateView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        emptyStateView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        emptyStateView.action = detailPresenter?.fetchCurrentWeather
        emptyStateView.isHidden = true
    }
    
}

extension DetailViewController: DetailViewProtocols {
    func setWeatherInfo(place: String, 
                        mainTemp: String,
                        weatherDescription: String,
                        minTemp: String,
                        maxTemp: String,
                        windSpeed: String,
                        windDeg: String) {
        placeLabel.text = place
        mainTempLabel.text = mainTemp + Constants.gradeSymbol
        weatherDescriptionLabel.text = weatherDescription
        minTempLabel.text = Wording.minTempKey + minTemp + Constants.gradeSymbol
        maxTempLabel.text = Wording.maxTempKey + maxTemp + Constants.gradeSymbol
        windSpeedLabel.text = Wording.windKey + windSpeed
        windDegLabel.text = "(" + windDeg + ")"
    }
    
    func setWeatherIcon(with imageData: Data) {
        if let image = UIImage(data: imageData)?.withRenderingMode(.alwaysOriginal) {
            weatherIconImageView.image = image
        }
    }
    
    func isEmptyStateHidden(isHidden: Bool) {
        emptyStateView.isHidden = isHidden
    }
    
    func setEmptyStateSubtitle(subtitle: String) {
        emptyStateView.subtitle = subtitle
    }
    
}


//Comented code to avoid unnecesary requests to backend on preview.

//#Preview("HomeViewController", traits: .defaultLayout, body: {
//    DetailModuleBuilder.build()
//})
