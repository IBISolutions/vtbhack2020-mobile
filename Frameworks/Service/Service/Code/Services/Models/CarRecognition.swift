//
//  CarRecognition.swift
//  VTB
//
//  Created by Иван Федоров on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Foundation

public struct CarRecognition: Codable {
    let probabilities: Probabilities
}

public struct Probabilities: Codable {
    
    //HACK: We don't care this values, only array of (string, double) tuples needs
    let bmw3: Double? = nil
    let bmw5: Double? = nil
    let cadillac: Double? = nil
    let chevrolet: Double? = nil
    let hundai: Double? = nil
    let jaguar: Double? = nil
    let kiaK5: Double? = nil
    let kiaOptima: Double? = nil
    let kiaSportage: Double? = nil
    let landRover: Double? = nil
    let mazda3: Double? = nil
    let mazda6: Double? = nil
    let mercedes: Double? = nil
    let toyota: Double? = nil
    
    let allProbabilities: [(String, Double)]
        
    enum CodingKeys: String, CodingKey, CaseIterable {
        case bmw3 = "BMW 3"
        case bmw5 = "BMW 5"
        case cadillac = "Cadillac ESCALADE"
        case chevrolet = "Chevrolet Tahoe"
        case hundai = "Hyundai Genesis"
        case jaguar = "Jaguar F-PACE"
        case kiaK5 = "KIA K5"
        case kiaOptima = "KIA Optima"
        case kiaSportage = "KIA Sportage"
        case landRover = "Land Rover RANGE ROVER VELAR"
        case mazda3 = "Mazda 3"
        case mazda6 = "Mazda 6"
        case mercedes = "Mercedes A"
        case toyota = "Toyota Camry"
    }
    
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        var probabilities: [(String, Double)] = []
        for key in CodingKeys.allCases {
            let value = try container.decode(Double.self, forKey: key)
            probabilities.append((key.rawValue, value))
        }
        allProbabilities = probabilities
    }
}
