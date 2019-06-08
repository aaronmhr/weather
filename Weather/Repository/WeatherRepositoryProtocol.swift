//
//  WeatherRepositoryProtocol.swift
//  Weather
//
//  Created by Aaron Huánuco on 06/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import RxSwift

protocol WeatherRepositoryProtocol {
    func retrieveWeatherForecast(url: URL) -> Single<CityForecast>
    func saveWeatherForecast(weatherForecast: CityForecast) -> Completable
    func readWeatherForecast(filterPredicate: String, date: Date) -> Single<CityForecast>
}
