//
//  DetailModuleBuilderStub.swift
//  WeatherAppTests
//
//  Created by Fede Flores on 03/03/2024.
//

import UIKit
@testable import WeatherApp

class DetailModuleBuilderStub {
    static func build() -> UIViewController {
        let view: DetailViewController = DetailViewController()
        let presenter: DetailPresenter = DetailPresenter()
        let interactor: DetailInteractor = DetailInteractor(provider: NetworkProviderStub())
        let router: DetailRouter = DetailRouter()
        
        view.detailPresenter = presenter
        
        presenter.detailView = view
        presenter.detailRouter = router
        presenter.detailInteractor = interactor
        
        interactor.detailPresenter = presenter
        
        router.viewController = view
        
        return view
    }
}


