//
//  Calculate.swift
//  VTB
//
//  Created by Иван Федоров on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Foundation

public struct Calculate: Codable {
    let result: CalculateResult
}

public struct CalculateResult: Codable {
    let contractRate: Double
    let kaskoCost: Double
    let loanAmount: Double
    let payment: Double
    let term: Int
}
