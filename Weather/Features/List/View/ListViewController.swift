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

    @IBOutlet private var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupCollectionView()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.barTintColor = .white
        let infoButton = UIButton(type: .infoLight)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: infoButton)
        title = "Weather"
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: ListCell.self)
    }
}

extension ListViewController: ListViewProtocol {

}

extension ListViewController: UICollectionViewDelegate {
    
}

extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ListCell = collectionView.dequeueReusableCell(for: indexPath)
        return cell
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: UIScreen.main.bounds.width, height: 80.0)
    }
}
