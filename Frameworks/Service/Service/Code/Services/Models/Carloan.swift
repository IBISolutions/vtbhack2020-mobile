//
//  Carloan.swift
//  VTB
//
//  Created by Иван Федоров on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Foundation

public struct CarLoan: Codable {
    let application: Application
}

public struct Application: Codable {
    let decisionReport: DecisionReport
}

public struct DecisionReport: Codable {
    let applicationStatus: String
    let comment: String
    let monthlyPayment: Int
}
