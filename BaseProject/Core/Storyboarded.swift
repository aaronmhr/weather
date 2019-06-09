//
//  Storyboarded.swift
//  BaseProject
//
//  Created by Aaron Huánuco on 01/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import UIKit

public protocol Storyboarded: class {
    static var storyboardName: String { get }
    static var storyboard: UIStoryboard { get }
}

public extension Storyboarded {
    static var storyboardName: String {
        return String(describing: self).replacingOccurrences(of: "Router", with: "")
    }
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: Bundle(for: Self.self))
    }
}


extension UIStoryboard {
    public func instantiateViewController<T: UIViewController>() -> T {
        let identifier = String(describing: T.self)
        guard let viewController: T = instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Failed to instantiate ViewController with identifier '\(identifier)'")
        }
        return viewController
    }
}
