//
//  ListViewController.swift
//  Weather
//
//  Created by Aaron Huánuco on 02/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import BaseProject
import UIKit

final class ListViewController: UIViewController {
    var presenter: ListPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ListViewController: ListViewProtocol {

}
