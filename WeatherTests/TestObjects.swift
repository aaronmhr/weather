//
//  TestObjects.swift
//  WeatherTests
//
//  Created by Aaron Huánuco on 08/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import CoreLocation
@testable import Weather

enum TestObjects {
    static let coordinates = CLLocation(latitude: 10.0, longitude: 10.0)
    static let weather = Weather(time: Date(), temperature: 10.0, image: nil, weatherDescription: nil)
    static let oldWeather = Weather(time: Date(timeIntervalSince1970: 0), temperature: 10.0, image: nil, weatherDescription: nil)
    static let futureWeather = Weather(time: Date(timeIntervalSinceNow: TimeInterval(10000)), temperature: 10.0, image: nil, weatherDescription: nil)
    static let cityForecast = CityForecast(city: "Paris", coordinates: coordinates, forecast: [weather])
    static let cityForecastMultiple = CityForecast(city: "Paris", coordinates: coordinates, forecast: [oldWeather, weather, futureWeather])
}
