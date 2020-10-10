//
//  CalculateParameters.swift
//  Service
//
//  Created by viktor.volkov on 10.10.2020.
//

import Foundation

public struct CalculateParameters {
    
    private enum Constants {
        static let kaskoId = "57ba0183-5988-4137-86a6-3d30a4ed8dc9"
        static let fullDocsId = "b907b476-5a26-4b25-b9c0-8091e9d5c65f"
        static let lifeCareId = "cbfc4ef3-af70-4182-8cf6-e73f361d1e68"
    }
    
    let cost: Double
    let initialFee: Double
    let term: Int
    let kaskoSelected: Bool
    let fullDocumentsPackageSelected: Bool
    let lifeCareSelected: Bool
    
    var selectedConditions: [String] {
        [
            (kaskoSelected, Constants.kaskoId),
            (fullDocumentsPackageSelected, Constants.fullDocsId),
            (lifeCareSelected, Constants.lifeCareId),
        ]
        .compactMap {
            $0.0 == true ? $0.1 : nil
        }
    }
}
