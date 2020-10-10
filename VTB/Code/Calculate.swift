//
//  Calculate.swift
//  VTB
//
//  Created by Иван Федоров on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Foundation

struct Calculate: Codable {
    let result: Result
}

struct Result: Codable {
    let contractRate: Double
    let kaskoCost: Double
    let loanAmount: Double
    let payment: Double
    let term: Int
}
