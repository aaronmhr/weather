//
//  ListProtocols.swift
//  Weather
//
//  Created by Aaron Huánuco on 02/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import BaseProject

protocol ListInteractorProtocol {
}

protocol ListRouterProtocol {
}

protocol ListPresenterProtocol {
    func viewDidLoad()
    func didSelectItemAtIndex(_ index: Int)
}

protocol ListViewProtocol: ViewControllerAdapter {
    var data: [ListCellViewModel] { get set }
    
}
