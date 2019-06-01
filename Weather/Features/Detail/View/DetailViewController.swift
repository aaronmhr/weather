//
//  DetailViewController.swift
//  Weather
//
//  Created by Aaron Huánuco on 02/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import UIKit
import BaseProject

final class DetailViewController: UIViewController {
    var presenter: DetailPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DetailViewController: DetailViewProtocol {

}
