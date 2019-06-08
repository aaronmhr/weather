//
//  RealmTests.swift
//  WeatherTests
//
//  Created by Aaron Huánuco on 08/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import XCTest
import RealmSwift
@testable import Weather

class RealmTests: XCTestCase {
    var sut: RealmService!

    override func setUp() {
        do {
            sut = RealmService(realm: try Realm())
        } catch {
            XCTFail()
        }
    }

    override func tearDown() {
        do { try sut.delete(RealmWeather.self) }
        catch { XCTFail() }
    }

    func testSaveAndRead() throws {
        let weather = RealmWeather.make(TestObjects.oldWeather)
        try sut.create(weather)
        
        guard let savedWeather = sut.read(RealmWeather.self).first else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(weather.image, savedWeather.image)
        XCTAssertEqual(weather.temperature, savedWeather.temperature)
        XCTAssertEqual(weather.time, savedWeather.time)
        XCTAssertEqual(weather.description, savedWeather.description)
    }
    
    func testDelete() throws {
        try sut.delete(RealmWeather.self)
        let savedWeather = sut.read(RealmWeather.self).first
        
        if let _ = savedWeather {
            XCTFail()
        } else {
            XCTAssertNil(savedWeather)
        }
    }
}
