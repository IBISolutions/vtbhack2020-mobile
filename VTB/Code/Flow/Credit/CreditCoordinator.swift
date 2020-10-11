//
//  CreditCoordinator.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Service

final class CreditCoordinator: BaseCoordinator {
    
    private let model: Model
    private let factory: CreditModuleFactory
    private let router: Router
    
    init(model: Model, router: Router, factory: CreditModuleFactory) {
        self.model = model
        self.factory = factory
        self.router = router
    }
    
    override func start() {
        showCreditResultModule(result: CalculateResult())
//        showCreditOfferModule()
//        showMakeCreditModule()
    }
    
    private func showMakeCreditModule() {
        let (view, output) = factory.makeCreditCalculatorModule(using: model)
        output.onCalculate = {
            [weak self] result in
            
            self?.showCreditResultModule(result: result)
        }
        router.setRootModule(view)
    }
    
    private func showCreditResultModule(result: CalculateResult) {
        let (view, output) = factory.makeCreditResultModule(photo: model.photo, result: result)
        output.onAction = {
            [weak self] action in
            
            switch action {
            case .createOffer:
                print("createoffer")
            case .schedule:
                print("schedule")
            }
        }
        router.setRootModule(view)
//        router.push(view)
    }
    
    private func showCreditOfferModule() {
        let (view, output) = factory.makeCreditOfferModule()
//        router.setRootModule(view)
    }
}
