//
//  + UIStackView.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import UIKit.UIStackView

public extension UIStackView {
    
    convenience init(subviews: [UIView] = [],
                     axis: NSLayoutConstraint.Axis = .horizontal,
                     spacing: CGFloat = .zero,
                     alignment: UIStackView.Alignment = .fill,
                     distribution: UIStackView.Distribution = .fill) {
        self.init(arrangedSubviews: subviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
    
    func addBackground(color: UIColor?) {
        guard let color = color else {
            return
        }
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: .zero)
    }
    
    @discardableResult
    func removeAllArrangedSubviews() -> [UIView] {
        let removedSubviews = arrangedSubviews.reduce(into: [UIView]()) {
            result, subview in
            
            self.removeArrangedSubview(subview)
            NSLayoutConstraint.deactivate(subview.constraints)
            subview.removeFromSuperview()
            result += [subview]
        }
        return removedSubviews
    }
}
