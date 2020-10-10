//
//  + UIColor.swift
//  Resources
//
//  Created by viktor.volkov on 10.10.2020.
//

import UIKit.UIColor

extension UIColor {
    
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )

        self.init(red: components.R, green: components.G, blue: components.B, alpha: alpha)
    }
}
