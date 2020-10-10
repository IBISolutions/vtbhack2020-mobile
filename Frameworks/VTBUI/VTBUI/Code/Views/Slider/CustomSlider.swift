//
//  CustomSlider.swift
//  VTBUI
//
//  Created by viktor.volkov on 10.10.2020.
//

import UIKit
import Resources

public class CustomSlider: UISlider {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        minimumTrackTintColor = Color.primaryBlue
        maximumTrackTintColor = Color.lightBlue
        setThumbImage(R.image.uI.thumb(), for: .normal)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
