//
//  DetailViewController.swift
//  Weather
//
//  Created by Aaron Huánuco on 02/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import MapKit
import BaseProject

final class DetailViewController: UIViewController {
    var presenter: DetailPresenterProtocol!
    @IBOutlet private var weatherImage: UIImageView!
    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var mapView: MKMapView!
    
    var model: ListCellViewModel? {
        didSet {
            guard let viewModel = model else { return }
            weatherImage.kf.setImage(with: viewModel.image)
            dayLabel.text = viewModel.day
            timeLabel.text = viewModel.time
            descriptionLabel.text = viewModel.weatherDescription
        }
    }
    
    var coordinates: CLLocation? {
        didSet {
            guard let coordinates = coordinates else { return }
            let regionRadius: CLLocationDistance = 2000
            let coordinateRegion = MKCoordinateRegion(center: coordinates.coordinate,
                                                      latitudinalMeters: regionRadius * 2.0,
                                                      longitudinalMeters: regionRadius * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        presenter.viewDidLoad()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.barTintColor = .white
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        button.addTarget(self, action:#selector(closeButtonAction), for: .touchUpInside)
    }
    
    @objc func closeButtonAction() {
        presenter.closeButtonDidPress()
    }
}

extension DetailViewController: DetailViewProtocol {

}
