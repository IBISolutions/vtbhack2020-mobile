//
//  CreditCalculatorPresenter.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Service

protocol CreditCalculatorControllerOutput: AnyObject {
    
    func viewDidLoad()
    func didTapOnCalculate()
    
}

protocol CreditCalculatorCoordinatorOutput: AnyObject {
    
    var onCalculate: Closure.Void? { get set }
}

final class CreditCalculatorPresenter: CreditCalculatorCoordinatorOutput {

    private let model: Model
    weak var view: CreditCalculatorView?
    var onCalculate: Closure.Void?

    init(model: Model, view: CreditCalculatorView) {
        self.model = model
        self.view = view
    }
}

extension CreditCalculatorPresenter: CreditCalculatorControllerOutput {
    
    func viewDidLoad() {
        let conditions = AppData.shared.settings?.specialConditions
        view?.configure(with: model, conditions: conditions)
    }
    
    func didTapOnCalculate() {
        onCalculate?()
    }
}
