//
//  CreditCalculatorPresenter.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//


protocol CreditCalculatorControllerOutput: AnyObject {
    
    func didTapOnCalculate()
}

protocol CreditCalculatorCoordinatorOutput: AnyObject {
    
    var onCalculate: Closure.Void? { get set }
}

final class CreditCalculatorPresenter: CreditCalculatorCoordinatorOutput {

    weak var view: CreditCalculatorView?
    var onCalculate: Closure.Void?

    init(view: CreditCalculatorView) {
        self.view = view
    }
}

extension CreditCalculatorPresenter: CreditCalculatorControllerOutput {
    
    func didTapOnCalculate() {
        onCalculate?()
    }
}
