//
//  CreditModuleFactory.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Service

protocol CreditModuleFactory {
    
    func makeCreditCalculatorModule(using model: Model) -> (Presentable, CreditCalculatorCoordinatorOutput)
    func makeCreditResultModule() -> (Presentable, CreditResultCoordinatorOutput)
}

extension ModuleFactory: CreditModuleFactory {
    
    func makeCreditCalculatorModule(using model: Model) -> (Presentable, CreditCalculatorCoordinatorOutput) {
        let controller = CreditCalculatorViewController()
        let presenter = CreditCalculatorPresenter(model: model, view: controller)
        controller.output = presenter
        return (controller, presenter)
    }
    
    func makeCreditResultModule() -> (Presentable, CreditResultCoordinatorOutput) {
        let controller = CreditResultViewController()
        let presenter = CreditResultPresenter(view: controller)
        controller.output = presenter
        return (controller, presenter)
    }
}
