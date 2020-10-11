//
//  PaymentsGraph.swift
//  VTB
//
//  Created by Иван Федоров on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Foundation

public struct PaymentsGraph: Codable {
    
    public let payments: [Payment]
}

public struct Payment: Codable {
    
    public let balanceOut: Double
    public let debt: Double
    public let order: Int
    public let payment: Double
    public let percent: Double
}
