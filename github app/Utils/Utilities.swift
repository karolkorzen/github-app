//
//  Utilities.swift
//  github app
//
//  Created by Karol Korzeń on 11/12/2020.
//

import UIKit

class Utilities {
    static let shared = Utilities()
    
    /// func creates  standar label of default size 14 and default weight .back
    /// - Parameters:
    ///   - size: font size
    ///   - weight: weight
    ///   - color: color
    /// - Returns: UILabel
    func standardLabel(withSize size: CGFloat = 14, withWeight weight: UIFont.Weight = .black, withColor color: UIColor = UIColor.rgb(red: 158, green: 158, blue: 158)) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        label.textColor = color
        return label
    }
    
    /// func creates UIImageView with defaut size 60x60
    /// - Parameters:
    ///   - width: width of image
    ///   - height: height of image
    /// - Returns: UIImageView
    func profileImageView(withWidth width: CGFloat = 60, withHeight height: CGFloat = 60) -> UIImageView {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: width, height: width)
        iv.layer.cornerRadius = 10
        return iv
    }
}

extension UIColor {
    
    /// func creates UIColor from mix of red, green and blue
    /// - Parameters:
    ///   - red: red colour (1-255)
    ///   - green: green colour (1-255)
    ///   - blue: blue colour (1-255)
    /// - Returns: UIColor
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

