//
//  ListInteractor.swift
//  Weather
//
//  Created by Aaron Huánuco on 02/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import BaseProject
import RxSwift

protocol ListInteractorDependenciesProtocol {
    var repository: WeatherRepositoryProtocol { get }
}

final class ListInteractorDependencies: ListInteractorDependenciesProtocol {
    lazy var repository: WeatherRepositoryProtocol = OpenWeatherRepository()
}

final class ListInteractor: InteractorProtocol {
    let dependencies: ListInteractorDependenciesProtocol

    init(dependencies: ListInteractorDependenciesProtocol = ListInteractorDependencies()) {
        self.dependencies = dependencies
    }
}

extension ListInteractor: ListInteractorProtocol {
    var weatherForecast: Single<CityForecast> {
        return dependencies.repository.retrieveWeatherForecast
    }
    
    var readWeathreForecastDataBase: Single<CityForecast> {
        return dependencies.repository.readWeatherForecast
    }
    
    func saveWeatherForecast(_ weatherForecast: CityForecast) -> Completable {
        return dependencies.repository.saveWeatherForecast(weatherForecast: weatherForecast)
    }
}
