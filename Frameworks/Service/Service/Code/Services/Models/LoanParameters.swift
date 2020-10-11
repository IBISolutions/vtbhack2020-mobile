//
//  LoanParameters.swift
//  Service
//
//  Created by viktor.volkov on 10.10.2020.
//

import Foundation

public struct LoanParameters {
    
    let email: String
    let incomeAmount: Int
    let phone: String
    let firstName: String
    let familyName: String
    let middleName: String
    let birthDateTime: String
    let birthPlace: String
    let tradeMark: String
    let requestedAmount: Int
    let requestedTerm: Int
    let vehicleCost: Int
    let interestRate: Double
    
    public init(email: String,
                incomeAmount: Int,
                phone: String,
                firstName: String,
                familyName: String,
                middleName: String,
                birthDateTime: String,
                birthPlace: String,
                tradeMark: String,
                requestedAmount: Int,
                requestedTerm: Int,
                vehicleCost: Int,
                interestRate: Double) {
        self.email = email
        self.incomeAmount = incomeAmount
        self.phone = phone
        self.firstName = firstName
        self.familyName = familyName
        self.middleName = middleName
        self.birthDateTime = birthDateTime
        self.birthPlace = birthPlace
        self.tradeMark = tradeMark
        self.requestedAmount = requestedAmount
        self.requestedTerm = requestedTerm
        self.vehicleCost = vehicleCost
        self.interestRate = interestRate
    }
}
