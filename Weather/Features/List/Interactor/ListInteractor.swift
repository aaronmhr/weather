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

final class ListInteractor {
    let dependencies: ListInteractorDependenciesProtocol

    init(dependencies: ListInteractorDependenciesProtocol = ListInteractorDependencies()) {
        self.dependencies = dependencies
    }
}

extension ListInteractor: ListInteractorProtocol {
    func urlStringForCity(_ city: String) -> URL? {
        let queryItems = [URLQueryItem(name: "q", value: city)]
        guard let stringURL = EndPoint.city.endpointUrl(with: queryItems)?.absoluteString,
            let url = URL(string: stringURL) else {
                return nil
        }
        return url
    }
    
    func weatherForecast(url: URL?) -> Single<CityForecast> {
        guard let url = url else {
            return .error(APIServiceError.invalidEndpoint)
        }
        return dependencies.repository.retrieveWeatherForecast(url: url)
    }
    
    var readWeatherForecastDataBase: Single<CityForecast> {
        let currentDate = Date()
        return dependencies.repository.readWeatherForecast(filterPredicate: Constants.databaseQuery, date: currentDate)
    }
    
    func saveWeatherForecast(_ weatherForecast: CityForecast) -> Completable {
        return dependencies.repository.saveWeatherForecast(weatherForecast: weatherForecast)
    }
}

private enum Constants {
    static let databaseQuery = "time >= %@"
}
