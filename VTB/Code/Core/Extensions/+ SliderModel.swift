//
//  + SliderModel.swift
//  VTB
//
//  Created by viktor.volkov on 11.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import VTBUI
import Resources

extension SliderModel {
    
    static let year = SliderModel(title: "Срок кредитования",
                                  valueMask: "%d лет", min: SliderBoundary(title: "%d год", value: 1),
                                  max: SliderBoundary(title: "%d лет", value: 5))
}
