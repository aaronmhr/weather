//
//  RealmWeather.swift
//  Weather
//
//  Created by Aaron Huánuco on 05/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import RealmSwift

final class RealmWeather: Object {
    @objc dynamic var time = Date()
    @objc dynamic var temperature = 0.0
    @objc dynamic var image: String? = nil
    @objc dynamic var weatherDescription: String? = nil
}

extension RealmWeather {
    static func make(_ weather: Weather) -> RealmWeather {
        let weatherRealm = RealmWeather()
        weatherRealm.time = weather.time
        weatherRealm.temperature = weather.temperature
        weatherRealm.image = weather.image
        weatherRealm.weatherDescription = weather.weatherDescription
        return weatherRealm
    }
    
    var asWeather: Weather {
        return Weather(time: self.time, temperature: self.temperature, image: self.image, weatherDescription: self.weatherDescription)
    }
}
