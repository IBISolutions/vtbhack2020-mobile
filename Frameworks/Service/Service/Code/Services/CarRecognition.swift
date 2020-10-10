//
//  CarRecognition.swift
//  VTB
//
//  Created by Иван Федоров on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Foundation

struct CarRecognition: Codable {
    let probabilities: [Probabilities]
}

struct Probabilities: Codable {
    
    var mazda6: Double
        
    enum CodingKeys: String, CodingKey {
        case mazda6 = "Mazda 6"
    }
    
}
