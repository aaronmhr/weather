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

final class ListPresenter: PresenterProtocol {
    let router: ListRouterProtocol
    let interactor: ListInteractorProtocol
    let disposeBag = DisposeBag()
    weak var view: ListViewProtocol!

    init(withView view: ListViewProtocol, interactor: ListInteractorProtocol, router: ListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    let apimanager = APIService()
    
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

extension ListPresenter: ListPresenterProtocol {
    func viewDidLoad() {
        interactor.weatherForecast
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                guard let self = self else  { return }
                switch event {
                case .success(let forecast):
                    self.handleSuccess(forecast: forecast)
                case .error:
                    self.handleError()
            }
        }
        .disposed(by: disposeBag)
    }

    func handleError() {
        interactor.readWeathreForecastDataBase
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                guard let self = self else  { return }
                switch event {
                case .success(let forecast):
                    self.handleSuccess(forecast: forecast)
                case .error(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
            .disposed(by: disposeBag)
    }
    
    func handleSuccess(forecast: CityForecast) {
        view.setupNavigationBarTitle(forecast.city)
        
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
        
        view.data = viewModels
    }

    func didSelectItemAtIndex(_ index: Int) {
        print(index)
    }
    
    private enum Constants {
        static let temperatureUnit = " ºC"
    }
}
