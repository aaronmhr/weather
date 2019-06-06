//
//  RealmServiceError.swift
//  Weather
//
//  Created by Aaron Huánuco on 05/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import Foundation

enum RealmServiceError: Error {
    case createError
    case deleteError
    case noObjectSavedError
}
