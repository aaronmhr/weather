//
//  RequestModels.swift
//  Weather
//
//  Created by Aaron Huánuco on 04/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import Foundation

// MARK: - Response
struct Response: Codable {
    let cod: String?
    let message: Double?
    let cnt: Int?
    let list: [ListResponse]
    let city: CityResponse?
}

// MARK: - CityResponse
struct CityResponse: Codable {
    let id: Int?
    let name: String?
    let country: String?
    let population, timezone: Int?
}

// MARK: - ListResponse
struct ListResponse: Codable {
    let dt: Int?
    let main: ForecastResponse?
    let weather: [WeatherResponse]
    let dtTxt: String?
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather
        case dtTxt = "dt_txt"
    }
}

// MARK: - MainClass
struct ForecastResponse: Codable {
    let temp: Double?
    let humidity: Int?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case humidity
    }
}

// MARK: - Weather
struct WeatherResponse: Codable {
    let weatherDescription, icon: String?
    
    enum CodingKeys: String, CodingKey {
        case weatherDescription = "description"
        case icon
    }
}

extension Response {
    var asWeatherForecast: CityForecast? {
        guard let city = self.city?.name else {
            return nil
        }
        let weatherArray = self.list.map { element -> Weather? in
            guard let temperature = element.main?.temp,
                let date = element.dt else {
                    return nil
            }
            let time = Date(timeIntervalSince1970: Double(date))
            let weather = element.weather.first
            return Weather(time: time, temperature: temperature, image: weather?.icon, weatherDescription: weather?.weatherDescription)
            }.compactMap { $0 }
        return CityForecast(city: city, forecast: weatherArray)
    }
}
