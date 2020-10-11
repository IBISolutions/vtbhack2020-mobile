//
//  PaymentGraphParameters.swift
//  Service
//
//  Created by viktor.volkov on 11.10.2020.
//

import Foundation

public struct PaymentGraphParameters {
    
    let contractRate: Double
    let lastPayment: Double = 0
    let loanAmount: Double
    let payment: Double
    let term: Int
    
    public static func from(calculate: CalculateResult) -> PaymentGraphParameters {
        PaymentGraphParameters(contractRate: calculate.contractRate,
                               loanAmount: calculate.loanAmount,
                               payment: calculate.payment,
                               term: calculate.term)
    }
}
