//
//  CarRecognitionOur.swift
//  Service
//
//  Created by viktor.volkov on 11.10.2020.
//

import Foundation

import Foundation

public struct CarRecognitionOur: Codable {
    public let probabilities: ProbabilitiesOur
}

public struct ProbabilitiesOur: Codable {
    
    //HACK: We don't care this values, only array of (string, double) tuples needs
    let hyundaiSolaris: Double? = nil
    let kiaRio: Double? = nil
    let volkswagenPolo: Double? = nil
    let volkswagenTiguan: Double? = nil
    let skodaOctavia: Double? = nil
    
    public let allProbabilities: [(String, Double)]
        
    enum CodingKeys: String, CodingKey, CaseIterable {
        case hyundaiSolaris = "Hyundai SOLARIS"
        case kiaRio = "KIA Rio"
        case volkswagenPolo = "Volkswagen Polo"
        case volkswagenTiguan = "Volkswagen Tiguan"
        case skodaOctavia = "ŠKODA OCTAVIA"
    }
    
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        var probabilitiesOur: [(String, Double)] = []
        for key in CodingKeys.allCases {
            let value = try container.decode(Double.self, forKey: key)
            probabilitiesOur.append((key.rawValue, value))
        }
        allProbabilities = probabilitiesOur
    }
}
