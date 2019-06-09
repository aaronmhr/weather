//
//  ListPresenterTests.swift
//  WeatherTests
//
//  Created by Aaron Huánuco on 08/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import XCTest
import CoreLocation
import BaseProject
import RxSwift
@testable import Weather

class ListPresenterTests: XCTestCase {
    
    private var sut: ListPresenter!
    private let view = MockListView()
    private let interactor = MockListInteractor()
    private let router = MockListRouter()
    
    override func setUp() {
        super.setUp()
        sut = ListPresenter(withView: view, interactor: interactor, router: router)
        view.presenter = sut
    }
    
    override func tearDown() {
        
    }
    
    func testTitleSetFunctionIsCalled() {
        sut.cityForecast = TestObjects.cityForecast
        XCTAssertTrue(view.isNavigationBarTitleSet)
    }
    
    func testViewViewModelsIsUpdatedWhenCellsAreAvailable() {
        let viewModel = sut.handleSuccess(forecast: TestObjects.cityForecastMultiple)
        sut.viewModels = viewModel
        XCTAssertEqual(sut.view.data, viewModel)
    }
}

// MARK: - Mock View

final class MockListView: ListViewProtocol {
    
    var presenter: ListPresenterProtocol!
    
    var data: [ListCellViewModel] = []
    var isNavigationBarTitleSet = false
    
    func setupNavigationBarTitle(_ title: String) {
        isNavigationBarTitleSet = true
    }
    func showError(error: Error) { }
}

// MARK: - Mock Interactor

final class MockListInteractor: ListInteractorProtocol {
    var readWeatherForecastDataBase: Single<CityForecast> {
        return Single<CityForecast>.create { single in
            single(.success(TestObjects.cityForecast))
            return Disposables.create()
        }
    }
    
    func urlStringForCity(_ city: String) -> URL? {
        return nil
    }
    
    func weatherForecast(url: URL?) -> Single<CityForecast> {
        return Single<CityForecast>.create { single in
            if let _ = url {
                single(.success(TestObjects.cityForecast))
            } else {
                single(.error(APIServiceError.invalidEndpoint))
            }
            return Disposables.create()
        }
    }
    
    func saveWeatherForecast(_ weatherForecast: CityForecast) -> Completable {
        return Completable.create { completable in
            completable(.completed)
            return Disposables.create()
        }
    }
}

// MARK: - Mock Router


final class MockListRouter: ListRouterProtocol {
    var isDetailedViewCalled = false

    func presentDetailView(cityForeCast: CityForecast, animated: Bool) {
        isDetailedViewCalled = true
    }
}
