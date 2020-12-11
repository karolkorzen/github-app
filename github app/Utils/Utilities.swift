//
//  Utilities.swift
//  github app
//
//  Created by Karol Korzeń on 11/12/2020.
//

import UIKit

class Utilities {
    static let shared = Utilities()
    
    /// func creates label with bold color of default size 14
    /// - Parameter size: text
    /// - Returns: UILabel
    func boldLabel(withSize size: CGFloat = 14) -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: size)
        label.tintColor = .black
        return label
    }
    
    /// func creates  standar label of default size 14 and default weight .back
    /// - Parameters:
    ///   - size: font size
    ///   - weight: weight
    /// - Returns: UILabel
    func standardLabel(withSize size: CGFloat = 14, withWeight weight: UIFont.Weight = .black) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        label.tintColor = UIColor.rgb(red: 158, green: 158, blue: 158)
        return label
    }
    
    func profileImageView(withWidth width: CGFloat = 60, withHeight height: CGFloat = 60) -> UIImageView {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: width, height: width)
        iv.layer.cornerRadius = 10
        iv.backgroundColor = .blue
        return iv
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

