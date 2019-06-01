//
//  ListInteractor.swift
//  Weather
//
//  Created by Aaron Huánuco on 02/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import BaseProject

protocol ListInteractorDependenciesProtocol {
}

final class ListInteractorDependencies: ListInteractorDependenciesProtocol {
}

final class ListInteractor: InteractorProtocol {
    let dependencies: ListInteractorDependenciesProtocol

    init(dependencies: ListInteractorDependenciesProtocol = ListInteractorDependencies()) {
        self.dependencies = dependencies
    }
}

extension ListInteractor: ListInteractorProtocol {

}
