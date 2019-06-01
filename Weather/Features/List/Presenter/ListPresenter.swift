//
//  ListPresenter.swift
//  Weather
//
//  Created by Aaron Huánuco on 02/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import BaseProject
import UIKit

final class ListPresenter: PresenterProtocol {
    let router: ListRouterProtocol
    let interactor: ListInteractorProtocol
    weak var view: ListViewProtocol!

    init(withView view: ListViewProtocol, interactor: ListInteractorProtocol, router: ListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension ListPresenter: ListPresenterProtocol {

}
