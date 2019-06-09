//
//  NibReusable.swift
//  BaseProject
//
//  Created by Aaron Huánuco on 01/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import UIKit

public protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

public protocol NibReusable: Reusable {
    static var nib: UINib { get }
}

public extension NibReusable {
    static var nib:  UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: Self.self))
    }
}

// MARK: - UITableView Extensions
public extension UITableView {
    final func register<T: UITableViewCell & NibReusable>(cellType: T.Type) {
        register(cellType.nib, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func  register<T: UITableViewHeaderFooterView & NibReusable>(cellType: T.Type) {
        register(cellType.nib, forHeaderFooterViewReuseIdentifier: cellType.reuseIdentifier)
    }
}


public extension UITableView {
    final func dequeueReusableCell<T: UITableViewCell & Reusable>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue reusable cell with identifier '\(T.reuseIdentifier)'.")
        }
        return cell
    }
    
    final func dequeueReusableCell<T: UITableViewHeaderFooterView & Reusable>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Failed to dequeue reusable cell with identifier '\(T.reuseIdentifier)'.")
        }
        return cell
    }
}

// MARK: - UICollectionView Extensions
public extension UICollectionView {
    final func register<T: UICollectionViewCell & NibReusable>(cellType: T.Type) {
        register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func  register<T: UICollectionReusableView & NibReusable>(headerType: T.Type) {
        register(headerType.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerType.reuseIdentifier)
    }
    
    final func  register<T: UICollectionReusableView & NibReusable>(footerType: T.Type) {
        register(footerType.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerType.reuseIdentifier)
    }
}


public extension UICollectionView {
    final func dequeueReusableCell<T: UICollectionViewCell & Reusable>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue reusable cell with identifier '\(T.reuseIdentifier)'.")
        }
        return cell
    }

    final func dequeueReusableHeader<T: UICollectionReusableView & Reusable>(for indexPath: IndexPath) -> T {
        guard let header = dequeueReusableSupplementaryView(ofKind: T.reuseIdentifier, withReuseIdentifier: UICollectionView.elementKindSectionHeader, for: indexPath) as? T else {
            fatalError("Failed to dequeue reusable cell with identifier '\(T.reuseIdentifier)'.")
        }
        return header
    }
    
    final func dequeueReusableFooter<T: UICollectionReusableView & Reusable>(for indexPath: IndexPath) -> T {
        guard let footer = dequeueReusableSupplementaryView(ofKind: T.reuseIdentifier, withReuseIdentifier: UICollectionView.elementKindSectionFooter, for: indexPath) as? T else {
            fatalError("Failed to dequeue reusable cell with identifier '\(T.reuseIdentifier)'.")
        }
        return footer
    }
}
