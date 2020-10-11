//
//  Calculate.swift
//  VTB
//
//  Created by Иван Федоров on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Foundation

public struct Calculate: Codable {
    
    public let result: CalculateResult
}

public struct CalculateResult: Codable {
    public let contractRate: Double
    public let kaskoCost: Double
    public let loanAmount: Double
    public let payment: Double
    public let term: Int
    
    public init() {
        contractRate = 0
        kaskoCost = 0
        loanAmount = 0
        payment = 0
        term = 0
    }
}
