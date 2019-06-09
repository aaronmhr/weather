//
//  DetailInteractor.swift
//  Weather
//
//  Created by Aaron Huánuco on 02/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import BaseProject

final class DetailInteractor {
    let cityForecast: CityForecast

    init(cityForecast: CityForecast) {
        self.cityForecast = cityForecast
    }
}

extension DetailInteractor: DetailInteractorProtocol {

}
