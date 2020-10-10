//
//  AppCoordinator.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Foundation

final class AppCoordinator: BaseCoordinator {
    
    
    private let router: Router
    private let coordinatorFactory: AppCoordinatorFactory
    private let moduleFactory: AppModuleFactory
    
    init(router: Router,
         coordinatorFactory: AppCoordinatorFactory,
         moduleFactory: AppModuleFactory) {
        
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.moduleFactory = moduleFactory
    }
    
    override func start() {
        let starterCoordinator = coordinatorFactory.makeStarterCoordinator(router: router)
        addDependency(starterCoordinator)
        starterCoordinator.start()
    }
}
