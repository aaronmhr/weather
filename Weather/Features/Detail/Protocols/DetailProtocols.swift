//
//  DetailProtocols.swift
//  Weather
//
//  Created by Aaron Huánuco on 02/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import BaseProject
import CoreLocation

protocol DetailInteractorProtocol {
    var cityForecast: CityForecast { get }
}

protocol DetailRouterProtocol {
    func closeScreen(animated: Bool)
}

protocol DetailPresenterProtocol {
    func viewDidLoad()
    func closeButtonDidPress()
}

protocol DetailViewProtocol: ErrorPresenter {
    var model: ListCellViewModel? { get set }
    var coordinates: CLLocation? { get set }
}
