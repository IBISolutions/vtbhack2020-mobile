//
//  PaymentsGraph.swift
//  VTB
//
//  Created by Иван Федоров on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Foundation

public struct PaymentsGraph: Codable {
    let payments: [Payment]
}

struct Payment: Codable {
    let balanceOut: Double
    let debt: Double
    let order: Int
    let payment: Double
    let percent: Double
}
