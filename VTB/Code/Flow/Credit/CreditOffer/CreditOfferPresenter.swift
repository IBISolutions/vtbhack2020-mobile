//
//  CreditOfferPresenter.swift
//  VTB
//
//  Created by viktor.volkov on 11.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Service

protocol CreditOfferControllerOutput: AnyObject {
    
    func didTapOnSend(email: String,
                      family: String,
                      name: String,
                      secondName: String,
                      phone: String,
                      city: String,
                      birthday: String)
}

protocol CreditOfferCoordinatorOutput: AnyObject {

}

final class CreditOfferPresenter {

    private let car: Model
    private let calculateResult: CalculateResult
    weak var view: CreditOfferView?
    private let service = NetworkService()

    init(car: Model, calculateResult: CalculateResult, view: CreditOfferView) {
        self.car = car
        self.calculateResult = calculateResult
        self.view = view
    }
}

extension CreditOfferPresenter: CreditOfferControllerOutput {
    
    func didTapOnSend(email: String,
                      family: String,
                      name: String,
                      secondName: String,
                      phone: String,
                      city: String,
                      birthday: String) {
        let incomeAmount = car.minPrice - Int(calculateResult.loanAmount)
        let parameters = LoanParameters(email: email,
                                        incomeAmount: incomeAmount,
                                        phone: phone,
                                        firstName: name,
                                        familyName: family,
                                        middleName: secondName,
                                        birthDateTime: birthday,
                                        birthPlace: city,
                                        tradeMark: car.title,
                                        requestedAmount: Int(calculateResult.loanAmount),
                                        requestedTerm: Int(calculateResult.term),
                                        vehicleCost: car.minPrice,
                                        interestRate: calculateResult.contractRate)
        service.loan(using: parameters) {
            result in
            
            print(result)
        }
        
    }
}

extension CreditOfferPresenter: CreditOfferCoordinatorOutput {
    
}
