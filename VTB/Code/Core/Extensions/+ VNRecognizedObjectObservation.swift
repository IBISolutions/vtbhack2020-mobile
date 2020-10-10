//
//  + VNRecognizedObjectObservation.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Vision

extension VNRecognizedObjectObservation {
    var label: String? {
        return self.labels.first?.identifier
    }
}
