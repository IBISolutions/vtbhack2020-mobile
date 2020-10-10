//
//  CreditCoordinator.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

final class CreditCoordinator: BaseCoordinator {
    
    private let factory: CreditModuleFactory
    private let router: Router
    
    init(router: Router, factory: CreditModuleFactory) {
        self.factory = factory
        self.router = router
    }
    
    override func start() {
        showMakeCreditModule()
    }
    
    private func showMakeCreditModule() {
        let (view, output) = factory.makeCreditCalculatorModule()
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
}
