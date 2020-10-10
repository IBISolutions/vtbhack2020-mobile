//
//  CustomView.swift
//  VTBUI
//
//  Created by viktor.volkov on 10.10.2020.
//

import UIKit

open class CustomView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    @available(*, unavailable, message: "init(coder:) has not been implemented")
    required public init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    open func configure() {}
}
