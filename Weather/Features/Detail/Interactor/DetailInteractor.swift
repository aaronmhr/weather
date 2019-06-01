//
//  DetailInteractor.swift
//  Weather
//
//  Created by Aaron Huánuco on 02/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import BaseProject

protocol DetailInteractorDependenciesProtocol {
}

final class DetailInteractorDependencies: DetailInteractorDependenciesProtocol {
}

final class DetailInteractor: InteractorProtocol {
    let dependencies: DetailInteractorDependenciesProtocol

    init(dependencies: DetailInteractorDependenciesProtocol = DetailInteractorDependencies()) {
        self.dependencies = dependencies
    }
}

extension DetailInteractor: DetailInteractorProtocol {

}
