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
        showCreditOfferModule()
//        showMakeCreditModule()
    }
    
    private func showMakeCreditModule() {
        let (view, output) = factory.makeCreditCalculatorModule(using: model)
        output.onCalculate = {
            [weak self] in
            
            self?.showCreditResultModule()
        }
        router.setRootModule(view)
    }
    
    private func showCreditResultModule() {
        let (view, output) = factory.makeCreditResultModule()
        output.onAction = {
            [weak self] action in
            
            switch action {
            case .createOffer:
                print("createoffer")
            case .schedule:
                print("schedule")
            }
        }
        router.push(view)
    }
    
    private func showCreditOfferModule() {
        let (view, output) = factory.makeCreditOfferModule()
        router.setRootModule(view)
    }
}
