//
//  StarterCoordinator.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import UIKit.UINavigationController

final class StarterCoordinator: BaseCoordinator {
    
    private let factory: StarterModuleFactory
    private let coordinatorFactory: StarterCoordinatorFactory
    private let router: Router
    
    init(router: Router, factory: StarterModuleFactory, coordinatorFactory: StarterCoordinatorFactory) {
        self.factory = factory
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        showStartScreenModule()
    }
    
    private func showStartScreenModule() {
        let (view, output) = factory.makeChooseFlow()
        output.onAction = {
            [weak self] action in
            
            switch action {
            case .startScan:
                self?.showScannerModule()
            case .chooseFromGallery:
                print("gal")
            }
        }
        router.setRootModule(view, hideBar: true)
    }
    
    private func showScannerModule() {
        let (view, output) = factory.makeScannerModule()
        output.onAction = {
            [weak self] action in
            
            switch action {
            case .scanned:
                self?.startCreditFlow()
            default:
                break
            }
        }
        router.push(view)
    }
    
    private func startCreditFlow() {
        let controller = UINavigationController()
        let coordinator = coordinatorFactory.makeCreditCoordinator(rootController: controller)
        addDependency(coordinator)
        coordinator.start()
        router.present(controller)
    }
}
