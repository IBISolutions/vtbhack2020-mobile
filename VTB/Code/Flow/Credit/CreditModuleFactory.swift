//
//  CreditModuleFactory.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

protocol CreditModuleFactory {
    
    func makeCreditCalculatorModule() -> (Presentable, CreditCalculatorCoordinatorOutput)
    func makeCreditResultModule() -> (Presentable, CreditResultCoordinatorOutput)
}

extension ModuleFactory: CreditModuleFactory {
    
    func makeCreditCalculatorModule() -> (Presentable, CreditCalculatorCoordinatorOutput) {
        let controller = CreditCalculatorViewController()
        let presenter = CreditCalculatorPresenter(view: controller)
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
