//
//  DetailPresenter.swift
//  Weather
//
//  Created by Aaron Huánuco on 02/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import UIKit
import BaseProject

final class DetailPresenter {
    let router: DetailRouterProtocol
    let interactor: DetailInteractorProtocol
    weak var view: DetailViewProtocol!

    init(withView view: DetailViewProtocol, interactor: DetailInteractorProtocol, router: DetailRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    lazy var dateFormatterDay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM/dd"
        return formatter
    }()
    
    lazy var dateFormatterTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        return formatter
    }()
}

extension DetailPresenter: DetailPresenterProtocol {
    func viewDidLoad() {
        let weather = interactor.cityForecast.forecast[0]
        let imageURL = EndPoint.icon(id: weather.image ?? "").endpointUrl(with: nil)?.absoluteString ?? ""
        let temperature: Double
        if #available(iOS 10.0, *) {
            let temperatureKelvin = Measurement(value: weather.temperature, unit: UnitTemperature.kelvin)
            temperature = temperatureKelvin.converted(to: UnitTemperature.celsius).value
        } else {
            temperature = weather.temperature - 273.15
        }
        let url = URL(string: imageURL)
        view.model =  ListCellViewModel(
            image: url,
            temperature: String(format: "%.1f", temperature) + Constants.temperatureUnit,
            time: dateFormatterTime.string(from: weather.time),
            weatherDescription: weather.weatherDescription,
            day: dateFormatterDay.string(from: weather.time)
        )
        view.coordinates = interactor.cityForecast.coordinates
    }
    
    func closeButtonDidPress() {
        router.closeScreen(animated: true)
    }
    
    private enum Constants {
        static let temperatureUnit = " ºC"
    }
}
