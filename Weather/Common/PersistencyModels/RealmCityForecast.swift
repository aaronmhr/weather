//
//  RealmCityForecast.swift
//  Weather
//
//  Created by Aaron Huánuco on 05/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import RealmSwift

final class RealmCityForecast: Object {
    @objc dynamic var city = ""
    dynamic var forecast: List<RealmWeather> = List()
    
    override static func primaryKey() -> String? {
        return "city"
    }
}

extension RealmCityForecast {
    static func make(_ cityForecast: CityForecast) -> RealmCityForecast {
        let realmCityForecast = RealmCityForecast()
        realmCityForecast.city = cityForecast.city
        cityForecast.forecast.forEach { realmCityForecast.forecast.append(RealmWeather.make($0)) }
        return realmCityForecast
    }
    
    var asCityForecast: CityForecast {
        let forecast = Array(self.forecast).map { $0.asWeather }
        return CityForecast(city: self.city, forecast: forecast)
    }
}
