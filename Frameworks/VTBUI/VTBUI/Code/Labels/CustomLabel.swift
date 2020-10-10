//
//  CustomLabel.swift
//  VTBUI
//
//  Created by viktor.volkov on 10.10.2020.
//

import UIKit

public extension UILabel {
    
    convenience init(lines: Int = 1,
                     size: CGFloat = 17,
                     weight: UIFont.Weight = .light,
                     color: UIColor = .black) {
        self.init()
        
        numberOfLines = lines
        font = UIFont.systemFont(ofSize: size, weight: weight)
        textColor = color
    }
}
