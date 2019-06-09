//
//  ListProtocols.swift
//  Weather
//
//  Created by Aaron Huánuco on 02/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import BaseProject
import RxSwift

protocol ListInteractorProtocol {
    var readWeatherForecastDataBase: Single<CityForecast> { get }
    
    func urlStringForCity(_ city: String) -> URL?
    func weatherForecast(url: URL?) -> Single<CityForecast>
    func saveWeatherForecast(_ weatherForecast: CityForecast) -> Completable
}

protocol ListRouterProtocol {
    func presentDetailView(cityForeCast: CityForecast, animated: Bool)
}

protocol ListPresenterProtocol {
    func viewDidLoad()
    func didSelectItemAtIndex(_ index: Int)
}

protocol ListViewProtocol: ErrorPresenter {
    var data: [ListCellViewModel] { get set }
    
    func setupNavigationBarTitle(_ title: String)
}
