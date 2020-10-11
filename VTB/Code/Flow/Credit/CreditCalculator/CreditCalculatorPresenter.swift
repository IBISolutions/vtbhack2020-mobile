//
//  CreditCalculatorPresenter.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Service
import VTBUI

protocol CreditCalculatorControllerOutput: AnyObject {
    
    func viewDidLoad()
    func didTapOnCalculate(paymentValue: Float, creditValue: Float, conditions: [String])
    
}

protocol CreditCalculatorCoordinatorOutput: AnyObject {
    
    var onCalculate: Closure.Generic<CalculateResult>? { get set }
}

final class CreditCalculatorPresenter: CreditCalculatorCoordinatorOutput {

    private let model: Model
    private let service = NetworkService()
    
    weak var view: CreditCalculatorView?
    var onCalculate: Closure.Generic<CalculateResult>?

    init(model: Model, view: CreditCalculatorView) {
        self.model = model
        self.view = view
    }
}

extension CreditCalculatorPresenter: CreditCalculatorControllerOutput {
    
    func viewDidLoad() {
        let conditions = AppData.shared.settings?.specialConditions
        let maxPrice = Float(model.minPrice)
        let minPrice = Float(model.minPrice) * 0.2
        let paymentMin = SliderBoundary(title: "%d Р", value: minPrice)
        let paymentMax = SliderBoundary(title: "%d Р", value: maxPrice)
        let paymentModel = SliderModel(title: "Первоначальный взнос",
                                       valueMask: "%d Р",
                                       min: paymentMin,
                                       max: paymentMax)
        
        view?.configure(with: model.name(),
                        photo: model.photo,
                        paymentsSliderModel: paymentModel,
                        creditSliderModel: SliderModel.year,
                        conditions: conditions)
    }
    
    func didTapOnCalculate(paymentValue: Float, creditValue: Float, conditions: [String]) {
        let parameter = CalculateParameters(cost: Float(model.minPrice),
                                            initialFee: paymentValue,
                                            term: Int(creditValue),
                                            conditions: conditions)
        service.calculate(using: parameter) {
            [weak self] res in
            
            if case .success(let result) = res {
                self?.onCalculate?(result.result)
            }
        }
    }
}
