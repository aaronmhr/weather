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

extension RealmServiceError: CustomStringConvertible {
    var description: String {
        switch self {
        case .createError:
            return "Could not save on database"
        case .deleteError:
            return "Could not delete from database"
        case .noObjectSavedError:
            return "Could not find or read saved object"
        }
    }
}
