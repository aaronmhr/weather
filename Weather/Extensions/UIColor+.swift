//
//  UIColor+.swift
//  Weather
//
//  Created by Aaron Huánuco on 02/06/2019.
//  Copyright © 2019 Aaron Huánuco. All rights reserved.
//

import UIKit

extension UIColor {
    
    private enum Constants {
        static let maxColorValue: CGFloat = 255
    }
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / Constants.maxColorValue, green: CGFloat(green) / Constants.maxColorValue, blue: CGFloat(blue) / Constants.maxColorValue, alpha: alpha)
    }
    
    static var redWeather: UIColor {
        return UIColor(red: 230, green: 57, blue: 67, alpha: 1)
    }
    
    static var coralWeather: UIColor {
        return UIColor(red: 242, green: 150, blue: 155, alpha: 1)
    }
    
    static var greyWeather: UIColor {
        return UIColor(red: 228, green: 228, blue: 228, alpha: 1)
    }
    
    static var blackWeather: UIColor {
        return UIColor(red: 255, green: 255, blue: 255, alpha: 1)
    }
    
    static var whiteWeather: UIColor {
        return UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
