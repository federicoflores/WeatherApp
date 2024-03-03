//
//  UIViewController+Extensions.swift
//  WeatherApp
//
//  Created by Fede Flores on 02/03/2024.
//

import UIKit

extension UIViewController {
    func showLoadingView() {
        Loader.sharedLoader.show()
    }
    
    func hideLoadingView() {
        Loader.sharedLoader.hide()
    }
}
