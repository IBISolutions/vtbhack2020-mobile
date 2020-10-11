//
//  CreditResultPresenter.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Service
import VTBUI

protocol CreditResultControllerOutput: AnyObject {
    
    func viewDidLoad()
    func didTapOnCreateOffer()
    func didTapOnPaymentsChart()
}

enum CreditResultCoordinatorAction {
    case createOffer, schedule
}

protocol CreditResultCoordinatorOutput: AnyObject {
    
    var onAction: Closure.Generic<CreditResultCoordinatorAction>? { get set }
}

final class CreditResultPresenter: CreditResultCoordinatorOutput {

    private let carName: String
    private let carPhoto: String
    private let result: CalculateResult
    weak var view: CreditResultView?
    
    var onAction: Closure.Generic<CreditResultCoordinatorAction>?

    init(carName: String, carPhoto: String, result: CalculateResult, view: CreditResultView) {
        self.carName = carName
        self.carPhoto = carPhoto
        self.result = result
        self.view = view
    }
}

extension CreditResultPresenter: CreditResultControllerOutput {
    
    func viewDidLoad() {
        let monthlyPaymentsModel = OverallModel(title: "Ежемесячный платеж",
                                                value: String(format: "%d Р", Int(result.payment)))
        let creditModel = OverallModel(title: "Ставка по кредиту",
                                       value: String(format: "%d %", result.contractRate))
        let creditSumModel = OverallModel(title: "Сумма кредита",
                                       value: String(format: "%d Р", Int(result.loanAmount)))
        let termModel = OverallModel(title: "Срок кредита",
                                       value: String(format: "%d лет%", Int(result.term)))
        view?.configure(with: carName,
                        photo: carPhoto,
                        monthlyPaymentsModel: monthlyPaymentsModel,
                        creditModel: creditModel,
                        creditSumModel: creditSumModel,
                        termModel: termModel)
    }
    
    func didTapOnCreateOffer() {
        onAction?(.createOffer)
    }
    
    func didTapOnPaymentsChart() {
        onAction?(.schedule)
    }
}
