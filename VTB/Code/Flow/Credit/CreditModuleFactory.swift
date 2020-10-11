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
    func makeCreditResultModule(photo: String, result: CalculateResult) -> (Presentable, CreditResultCoordinatorOutput)
    func makeCreditOfferModule() -> (Presentable, CreditOfferCoordinatorOutput)
}

extension ModuleFactory: CreditModuleFactory {
    
    func makeCreditCalculatorModule(using model: Model) -> (Presentable, CreditCalculatorCoordinatorOutput) {
        let controller = CreditCalculatorViewController()
        let presenter = CreditCalculatorPresenter(model: model, view: controller)
        controller.output = presenter
        return (controller, presenter)
    }
    
    func makeCreditResultModule(photo: String, result: CalculateResult) -> (Presentable, CreditResultCoordinatorOutput) {
        let controller = CreditResultViewController()
        let presenter = CreditResultPresenter(carPhoto: photo,
                                              result: result,
                                              view: controller)
        controller.output = presenter
        return (controller, presenter)
    }
    
    func makeCreditOfferModule() -> (Presentable, CreditOfferCoordinatorOutput) {
        let controller = CreditOfferViewController()
        let presenter = CreditOfferPresenter(view: controller)
        controller.output = presenter
        return (controller, presenter)
    }
}
