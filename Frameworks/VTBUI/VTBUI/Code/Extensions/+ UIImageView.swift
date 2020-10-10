//
//  + UIImageView.swift
//  VTBUI
//
//  Created by viktor.volkov on 10.10.2020.
//

import UIKit

public extension UIImageView {
    
    convenience init(contentMode: UIView.ContentMode, image: UIImage? = nil, clipsToBounds: Bool = false) {
        self.init(image: image)
        self.contentMode = contentMode
        self.clipsToBounds = clipsToBounds
    }
}
