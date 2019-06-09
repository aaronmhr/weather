//
//  ListPresenter.swift
//  Weather
//
//  Created by Aaron Huánuco on 02/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import BaseProject
import UIKit
import RxSwift

final class ListPresenter {
    let router: ListRouterProtocol
    let interactor: ListInteractorProtocol
    let apimanager = APIService()
    let disposeBag = DisposeBag()
    weak var view: ListViewProtocol!
    
    var cityForecast: CityForecast? {
        willSet {
            guard let cityForecast = newValue else { return }
            view.setupNavigationBarTitle(cityForecast.city)
        }
    }

    init(withView view: ListViewProtocol, interactor: ListInteractorProtocol, router: ListRouterProtocol) {
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
    
    var viewModels: [ListCellViewModel] = [] {
        willSet {
            view.data = newValue
        }
    }
}

extension ListPresenter: ListPresenterProtocol {
    func viewDidLoad() {
        interactor.weatherForecast(url: interactor.urlStringForCity(Constants.paris))
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                guard let self = self else  { return }
                switch event {
                case .success(let forecast):
                    let viewModels = self.handleSuccess(forecast: forecast)
                    self.viewModels = viewModels
                case .error:
                    self.handleError()
                }
        }
        .disposed(by: disposeBag)
    }

    func handleError() {
        interactor.readWeatherForecastDataBase
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                guard let self = self else  { return }
                switch event {
                case .success(let forecast):
                    let viewModels = self.handleSuccess(forecast: forecast)
                    self.viewModels = viewModels
                case .error(let error):
                    self.view.showError(error: error)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func handleSuccess(forecast: CityForecast) -> [ListCellViewModel] {
        cityForecast = forecast
        
        let viewModels = forecast.forecast.map { weather -> ListCellViewModel in
            let imageURL = EndPoint.icon(id: weather.image ?? "").endpointUrl(with: nil)?.absoluteString ?? ""
            let temperature: Double
            if #available(iOS 10.0, *) {
                let temperatureKelvin = Measurement(value: weather.temperature, unit: UnitTemperature.kelvin)
                temperature = temperatureKelvin.converted(to: UnitTemperature.celsius).value
            } else {
                temperature = weather.temperature - 273.15
            }
            let url = URL(string: imageURL)
            return ListCellViewModel(image: url,
                                     temperature: String(format: "%.1f", temperature) + Constants.temperatureUnit,
                                     time: dateFormatterTime.string(from: weather.time),
                                     weatherDescription: weather.weatherDescription,
                                     day: dateFormatterDay.string(from: weather.time))
        }
        return viewModels
    }

    func didSelectItemAtIndex(_ index: Int) {
        guard let cityForecast = cityForecast,
        cityForecast.forecast.indices.contains(index) else {
            view.showError(error: WeatherError.generic)
            return
        }
        let detailCityForecast = CityForecast(city: cityForecast.city, coordinates: cityForecast.coordinates, forecast: [cityForecast.forecast[index]])
        router.presentDetailView(cityForeCast: detailCityForecast, animated: true)
    }
    
    private enum Constants {
        static let temperatureUnit = " ºC"
        static let paris = "Paris,fr"
    }
}
