//
//  CityForecast.swift
//  Weather
//
//  Created by Aaron Huánuco on 04/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import CoreLocation

struct CityForecast: Equatable {
    let city: String
    let coordinates: CLLocation
    let forecast: [Weather]
}
