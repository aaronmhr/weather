//
//  DetailInteractorTests.swift
//  WeatherTests
//
//  Created by Aaron Huánuco on 08/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Weather

class DetailInteractorTests: XCTestCase {
    
    private var sut: DetailInteractor!
    
    override func setUp() {
        super.setUp()
        sut = DetailInteractor(cityForecast: TestObjects.cityForecast)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDataSource() {
        XCTAssertEqual(sut.cityForecast, TestObjects.cityForecast)
    }
}
