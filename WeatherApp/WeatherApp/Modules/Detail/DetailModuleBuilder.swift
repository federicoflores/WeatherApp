//
//  DetailModuleBuilder.swift
//  WeatherApp
//
//  Created by Fede Flores on 02/03/2024.
//

import UIKit

class DetailModuleBuilder {
    static func build() -> UIViewController {
        let view: DetailViewController = DetailViewController()
        let presenter: DetailPresenter = DetailPresenter()
        let interactor: DetailInteractor = DetailInteractor(provider: NetworkProvider())
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
