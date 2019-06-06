//
//  Endpoint.swift
//  Weather
//
//  Created by Aaron Huánuco on 02/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import Foundation

enum EndPoint {
    case city
    case icon(id: String)
    
    func endpointUrl(with items: [URLQueryItem]?) -> URL? {
        var components = URLComponents()
        var items = items
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        switch self {
        case .city:
            items?.append(URLQueryItem(name: Constants.appID, value: Constants.key))
            components.path = "\(Path.forecast.rawValue)"
        case .icon(id: let id):
            components.path = "\(Path.icon.rawValue)/\(id)\(Constants.iconExtension)"
        }
        components.queryItems = items
        return components.url
    }
}

extension EndPoint {
    enum Constants {
        static let scheme = "https"
        static let baseURL = "api.openweathermap.org"
        static let appID = "APPID"
        static let key = "18c2208358da7db8a9295fa83b9b7c75"
        static let iconExtension = ".png"
    }
    
    private enum Path: String {
        case forecast = "/data/2.5/forecast"
        case icon = "/img/w"
    }
}
