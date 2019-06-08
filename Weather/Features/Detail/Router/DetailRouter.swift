//
//  DetailRouter.swift
//  Weather
//
//  Created by Aaron Huánuco on 02/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import UIKit
import BaseProject
import CoreLocation

final class DetailRouter: RouterProtocol {
    weak var view: DetailViewController!

    init(withView view: DetailViewController) {
        self.view = view
    }

    static func assembleModule(cityForecast: CityForecast,
        viewController: DetailViewController = defaultViewController) -> UIViewController {
        let router = DetailRouter(withView: viewController)

        let interactor = DetailInteractor(cityForecast: cityForecast)
        let presenter = DetailPresenter(withView: viewController, interactor: interactor, router: router)

        viewController.presenter = presenter

        return viewController
    }

    static var defaultViewController: DetailViewController {
        return storyboard.instantiateViewController()
    }
}

extension DetailRouter: DetailRouterProtocol {
    func closeScreen(animated: Bool) {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            view.dismiss(animated: animated, completion: nil)
        case .phone:
            view.navigationController?.popViewController(animated: animated)
        default:
            view.showError(error: WeatherError.generic)
        }
    }
}
