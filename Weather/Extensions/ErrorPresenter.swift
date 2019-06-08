//
//  ErrorPresenter.swift
//  Weather
//
//  Created by Aaron Huánuco on 07/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import BaseProject

extension ViewControllerAdapter {
    func showError(error: Error) {
        switch error {
        case let apiError as APIServiceError:
            showAPIError(error: apiError)
        case let databaseError as RealmServiceError:
            showDatabaseError(error: databaseError)
        default:
            let alert = UIAlertController(title: Constants.error, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constants.button, style: .default, handler: nil))
            present(alert, animated: true)
        }
    }
    
    private func showAPIError(error: APIServiceError) {
        let alert = UIAlertController(title: Constants.error, message: error.description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.button, style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    private func showDatabaseError(error: RealmServiceError) {
        let alert = UIAlertController(title: Constants.error, message: error.description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.button, style: .default, handler: nil))
        present(alert, animated: true)
    }
}

private enum Constants {
    static let error = "Error"
    static let button = "OK"
}
