//
//  ListViewController.swift
//  Weather
//
//  Created by Aaron Huánuco on 02/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import BaseProject
import UIKit

final class ListViewController: UIViewController, ListViewProtocol {
    var presenter: ListPresenterProtocol!
    
    var data: [ListCellViewModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    @IBOutlet private var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupCollectionView()
        presenter.viewDidLoad()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.barTintColor = .white
        let infoButton = UIButton(type: .infoLight)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: infoButton)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: ListCell.self)
    }
    
    func setupNavigationBarTitle(_ title: String) {
        self.title = title
    }
}

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAtIndex(indexPath.item)
    }
}

extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ListCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setupCell(listViewModel: data[indexPath.row]) 
        return cell
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: UIScreen.main.bounds.width, height: 100.0)
    }
}
