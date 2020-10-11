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
    func makeCreditResultModule(carName: String, photo: String, result: CalculateResult) -> (Presentable, CreditResultCoordinatorOutput)
    func makeCreditOfferModule(car: Model, calculateResult: CalculateResult) -> (Presentable, CreditOfferCoordinatorOutput)
    func makeGraphModule(parameters: PaymentGraphParameters) -> (Presentable, GraphCoordinatorOutput)
}

extension ModuleFactory: CreditModuleFactory {
    
    func makeCreditCalculatorModule(using model: Model) -> (Presentable, CreditCalculatorCoordinatorOutput) {
        let controller = CreditCalculatorViewController()
        let presenter = CreditCalculatorPresenter(model: model, view: controller)
        controller.output = presenter
        return (controller, presenter)
    }
    
    func makeCreditResultModule(carName: String, photo: String, result: CalculateResult) -> (Presentable, CreditResultCoordinatorOutput) {
        let controller = CreditResultViewController()
        let presenter = CreditResultPresenter(carName: carName,
                                              carPhoto: photo,
                                              result: result,
                                              view: controller)
        controller.output = presenter
        return (controller, presenter)
    }
    
    func makeCreditOfferModule(car: Model, calculateResult: CalculateResult) -> (Presentable, CreditOfferCoordinatorOutput) {
        let controller = CreditOfferViewController()
        let presenter = CreditOfferPresenter(car: car, calculateResult: calculateResult, view: controller)
        controller.output = presenter
        return (controller, presenter)
    }
    
    func makeGraphModule(parameters: PaymentGraphParameters) -> (Presentable, GraphCoordinatorOutput) {
        let controller = GraphViewController()
        let presenter = GraphPresenter(parameters: parameters, view: controller)
        controller.output = presenter
        return (controller, presenter)
    }
}
