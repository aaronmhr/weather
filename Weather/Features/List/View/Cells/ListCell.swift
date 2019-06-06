//
//  ListCell.swift
//  Weather
//
//  Created by Aaron Huánuco on 02/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import UIKit
import BaseProject
import Kingfisher

final class ListCell: UICollectionViewCell, NibReusable {
    @IBOutlet private var weatherImage: UIImageView!
    @IBOutlet private var temperautre: UILabel!
    @IBOutlet private var time: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var day: UILabel!
    @IBOutlet private var iPadDay: UILabel!
}

extension ListCell {
    func setupCell(listViewModel: ListCellViewModel) {
        weatherImage.kf.setImage(with: listViewModel.image)
        temperautre.text = listViewModel.temperature
        time.text = listViewModel.time
        descriptionLabel.text = listViewModel.weatherDescription
        day.text = listViewModel.day
        iPadDay.text = listViewModel.day
    }
    
    private func setupStyles() {
        temperautre.font = UIFont.light30
        time.font = UIFont.regular20
        descriptionLabel.font = UIFont.regular12
        day.font = UIFont.regular10
    }
}
