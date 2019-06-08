//
//  ListCellViewModel.swift
//  Weather
//
//  Created by Aaron Huánuco on 02/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import UIKit

struct ListCellViewModel: Equatable {
    let image: URL?
    let temperature: String
    let time: String
    let weatherDescription: String?
    let day: String
}
