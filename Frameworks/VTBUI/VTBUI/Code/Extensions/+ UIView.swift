//
//  + UIView.swift
//  VTBUI
//
//  Created by viktor.volkov on 10.10.2020.
//

import UIKit

public extension UIView {
    
    convenience init(backgroundColor: UIColor = .clear,
                     isHidden: Bool = false,
                     isUserInteractionEnabled: Bool = true) {
        self.init()
        self.backgroundColor = backgroundColor
        self.isHidden = isHidden
        self.isUserInteractionEnabled = isUserInteractionEnabled
    }
    
    func setRequiredContentHuggingPriority(_ axis: NSLayoutConstraint.Axis) {
        setContentHuggingPriority(.required, for: axis)
        
        subviews.forEach {
            $0.setRequiredContentHuggingPriority(axis)
        }
    }
    
    func setRequiredCompressionResistancePriority(_ axis: NSLayoutConstraint.Axis) {
        setContentCompressionResistancePriority(.required, for: axis)
        
        subviews.forEach {
            $0.setRequiredCompressionResistancePriority(axis)
        }
    }
}

