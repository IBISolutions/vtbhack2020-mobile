//
//  + UIView.swift
//  VTBUI
//
//  Created by viktor.volkov on 10.10.2020.
//

import UIKit

public extension UIView {
    
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

