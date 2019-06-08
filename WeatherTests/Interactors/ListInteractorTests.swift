//
//  ListInteractorTests.swift
//  WeatherTests
//
//  Created by Aaron Huánuco on 08/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import XCTest
import CoreLocation
import RxSwift
@testable import Weather

class ListInteractorTests: XCTestCase {
    
    private enum Constants {
        static let temperatureUnit = " ºC"
        static let paris = "Paris,fr"
    }
    
    private var sut1: ListInteractor!
    private var sut2: ListInteractor!
    let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        sut1 = ListInteractor(dependencies: MockListInteractorDependencies())
        sut2 = ListInteractor(dependencies: ListInteractorDependencies())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testURLCreation() {
        let urlForNil =  sut1.urlStringForCity(Constants.paris)
        XCTAssertNotNil(urlForNil)
    }
    
    func testInvalidPointErrorShouldBeReturnedWhenURLIsNil() {
        sut1.weatherForecast(url: nil)
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .success(_):
                    XCTFail()
                case .error(let errorResponse):
                    guard let error =  errorResponse as? APIServiceError else {
                        XCTFail()
                        return
                    }
                    XCTAssertEqual(error, APIServiceError.invalidEndpoint)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func testCityForecastIsRetrievedFromAPI() {
        sut1.weatherForecast(url: sut1.urlStringForCity(Constants.paris))
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .success(let cityForecast):
                    XCTAssertEqual(cityForecast, TestObjects.cityForecast)
                case .error(let errorResponse):
                    guard let error =  errorResponse as? APIServiceError else {
                        XCTFail()
                        return
                    }
                    XCTAssertEqual(error, APIServiceError.invalidEndpoint)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func testCityForecastIsRetrievedFromDatabase() {
        
        sut2.saveWeatherForecast(TestObjects.cityForecastMultiple)
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                switch event {
                case .completed:
                    self?.retrieveFromDatabase()
                case .error:
                    XCTFail()
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func retrieveFromDatabase() {
        let now  = Date()
        sut2.readWeatherForecastDataBase
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .success(let cityForecast):
                    XCTAssertEqual(cityForecast.forecast, TestObjects.cityForecastMultiple.forecast.filter({ $0.time >= now }))
                case .error:
                    XCTFail()
                }
            }
            .disposed(by: disposeBag)
    }
}


final class MockListInteractorDependencies: ListInteractorDependenciesProtocol {
    lazy var repository: WeatherRepositoryProtocol = MockOpenWeatherRepository()
}

final class MockOpenWeatherRepository: WeatherRepositoryProtocol {
    lazy var persistencyService = RealmService()
    
    func readWeatherForecast(filterPredicate: String, date: Date) -> Single<CityForecast> {
        return Single<CityForecast>.create { single in
            single(.success(TestObjects.cityForecast))
            return Disposables.create()
        }
    }
    
    func retrieveWeatherForecast(url: URL) -> Single<CityForecast> {
        return Single<CityForecast>.create { single in
            single(.success(TestObjects.cityForecast))
            return Disposables.create()
        }
    }
    
    func saveWeatherForecast(weatherForecast: CityForecast) -> Completable {
        return Completable.create { [weak self] completable in
            do {
                try self?.persistencyService.delete(RealmWeather.self)
                try self?.persistencyService.delete(RealmCityForecast.self)
                
                do {
                    try self?.persistencyService.create(RealmCityForecast.make(weatherForecast))
                } catch {
                    completable(.error(RealmServiceError.createError))
                    return Disposables.create()
                }
            } catch {
                completable(.error(RealmServiceError.deleteError))
                return Disposables.create()
            }
            completable(.completed)
            return Disposables.create()
        }
    }
}
