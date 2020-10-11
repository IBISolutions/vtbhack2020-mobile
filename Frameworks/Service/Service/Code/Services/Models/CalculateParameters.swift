//
//  CalculateParameters.swift
//  Service
//
//  Created by viktor.volkov on 10.10.2020.
//

import Foundation

public struct CalculateParameters {
    
    let cost: Float
    let initialFee: Float
    let term: Int
    var selectedConditions: [String]
    
    public init(cost: Float, initialFee: Float, term: Int, conditions: [String]) {
        self.cost = cost
        self.initialFee = initialFee
        self.term = term
        self.selectedConditions = conditions
    }
}
