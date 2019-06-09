//
//  ListRouter.swift
//  Weather
//
//  Created by Aaron Huánuco on 02/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import BaseProject
import UIKit

final class ListRouter: Storyboarded {
    weak var view: ListViewController!

    init(withView view: ListViewController) {
        self.view = view
    }

    static func assembleModule(viewController: ListViewController = defaultViewController) -> UIViewController {
        let router = ListRouter(withView: viewController)

        let interactor = ListInteractor()
        let presenter = ListPresenter(withView: viewController, interactor: interactor, router: router)

        viewController.presenter = presenter

        return viewController
    }

    static var defaultViewController: ListViewController {
        return storyboard.instantiateViewController()
    }
}

extension ListRouter: ListRouterProtocol {
    func presentDetailView(cityForeCast: CityForecast, animated: Bool) {
        let detailViewController = DetailRouter.assembleModule(cityForecast: cityForeCast)
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            let navigationController = UINavigationController(rootViewController: detailViewController)
            view.present(navigationController, animated: animated, completion: nil)
        case .phone:
            view.navigationController?.pushViewController(detailViewController, animated: animated)
        default:
            view.showError(error: WeatherError.generic)
        }
    }
}


enum WeatherError: Error {
    case generic
    
    var localizedDescription: String {
        return "Something went wrong"
    }
}
