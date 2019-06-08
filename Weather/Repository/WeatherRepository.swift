//
//  WeatherRepository.swift
//  Weather
//
//  Created by Aaron Huánuco on 04/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import RxSwift
import CoreLocation

protocol OpenWeatherDependenciesProtocol {
    var apiService: APIService { get }
    var persistencyService: RealmService { get }
}

final class OpenWeatherDependencies: OpenWeatherDependenciesProtocol {
    lazy var apiService = APIService()
    lazy var persistencyService = RealmService()
}

final class OpenWeatherRepository: WeatherRepositoryProtocol {
    let dependencies: OpenWeatherDependenciesProtocol
    
    init(dependencies: OpenWeatherDependenciesProtocol = OpenWeatherDependencies()) {
        self.dependencies = dependencies
    }
    
    func retrieveWeatherForecast(url: URL) -> Single<CityForecast> {
        return Single<CityForecast>.create { [weak self] single in            
            self?.dependencies.apiService.fetchResources(url: url, completion: { (result: Result<Response, APIServiceError>) in
                switch result {
                case .success(let response):
                    guard let forecast = response.asWeatherForecast else {
                        single(.error(APIServiceError.invalidResponse))
                        return
                    }
                    single(.success(forecast))
                case .failure(let error):
                    single(.error(error))
                }
            })
            return Disposables.create()
        }
    }
    
    func readWeatherForecast(filterPredicate: String, date: Date) -> Single<CityForecast> {
        return Single<CityForecast>.create { [weak self] single in
            let results = self?.dependencies.persistencyService.read(RealmCityForecast.self)
            guard let forecastDatabaseResult = results?.first?.forecast.filter(filterPredicate, date),
                let cityDatabase = results?.first else {
                    single(.error(RealmServiceError.noObjectSavedError))
                    return Disposables.create()
            }
            let forecastDatabase = Array(forecastDatabaseResult.map { $0.asWeather })
            let realmForecast = CityForecast(city: cityDatabase.city,
                                             coordinates: CLLocation(latitude: cityDatabase.latitude, longitude: cityDatabase.longitude),
                                             forecast: forecastDatabase)
            single(.success(realmForecast))
            return Disposables.create()
        }
    }
    
    func saveWeatherForecast(weatherForecast: CityForecast) -> Completable {
        return Completable.create { [weak self] completable in
            guard let self = self else {
                completable(.error(RealmServiceError.noObjectSavedError))
                return Disposables.create()
            }
            do {
                try self.dependencies.persistencyService.delete(RealmWeather.self)
                try self.dependencies.persistencyService.delete(RealmCityForecast.self)
                
                do {
                    try self.dependencies.persistencyService.create(RealmCityForecast.make(weatherForecast))
                } catch {
                    completable(.error(RealmServiceError.createError))
                    return Disposables.create()
                }
            } catch {
                completable(.error(RealmServiceError.deleteError))
                return Disposables.create()
            }
            completable(.completed)
            return Disposables.create()
        }
    }
}
