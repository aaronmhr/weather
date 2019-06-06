//
//  APIServiceError.swift
//  Weather
//
//  Created by Aaron Huánuco on 02/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import Foundation

enum APIServiceError: Error {
    case apiError(String)
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
}
