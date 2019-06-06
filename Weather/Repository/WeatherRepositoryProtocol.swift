//
//  WeatherRepositoryProtocol.swift
//  Weather
//
//  Created by Aaron Huánuco on 06/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import RxSwift

protocol WeatherRepositoryProtocol {
    var retrieveWeatherForecast: Single<CityForecast> { get }
    var readWeatherForecast: Single<CityForecast>  { get }
    
    func saveWeatherForecast(weatherForecast: CityForecast) -> Completable
}
