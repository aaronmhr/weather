//
//  UIFont+.swift
//  Weather
//
//  Created by Aaron Huánuco on 02/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import UIKit

extension UIFont {
    public static var regular10 : UIFont {
        return UIFont.systemFont(ofSize: 10)
    }
    
    public static var regular12: UIFont {
        return UIFont.systemFont(ofSize: 12)
    }
    
    public static var regular20: UIFont {
        return UIFont.systemFont(ofSize: 20)
    }
    
    public static var bold14: UIFont {
        if #available(iOS 8.2, *) {
            return UIFont.systemFont(ofSize: 14, weight: .bold)
        } else {
            return UIFont.systemFont(ofSize: 14)
        }
    }
    
    public static var light30: UIFont {
        if #available(iOS 8.2, *) {
            return UIFont.systemFont(ofSize: 30, weight: .light)
        } else {
            return UIFont.systemFont(ofSize: 30)
        }
    }
}
