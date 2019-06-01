//
//  ListRouter.swift
//  Weather
//
//  Created by Aaron Huánuco on 02/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import UIKit

final class ListRouter: RouterProtocol {
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

}
