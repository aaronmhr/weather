//
//  EndpointTests.swift
//  WeatherTests
//
//  Created by Aaron Huánuco on 03/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import XCTest
@testable import Weather

class EndpointTests: XCTestCase {
    
    private enum Constants {
        static let paris = "Paris,fr"
    }
    
    func testCityEndpoint() {
        // Given
        let sut: EndPoint = EndPoint.city
        let queryItems = [URLQueryItem(name: "q", value: Constants.paris)]
        let expectedUrl = "https://api.openweathermap.org/data/2.5/forecast?q=\(Constants.paris)&APPID=\(EndPoint.Constants.key)"
        
        // When
        let urlString = sut.endpointUrl(with: queryItems)?.absoluteString
        
        // Then
        XCTAssertEqual(expectedUrl, urlString, "Endpoing URL should contain query items")
    }
    
    func testIconEndpoint() {
        // Given
        let sut: EndPoint = EndPoint.icon(id: "10d")
        let expectedUrl = "https://api.openweathermap.org/img/w/10d.png"

        // When
        let urlString = sut.endpointUrl(with: nil)?.absoluteString

        // Then
        XCTAssertEqual(expectedUrl, urlString, "Endpoing URL should match expected one")
    }
}
