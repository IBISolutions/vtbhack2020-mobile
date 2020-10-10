//
//  AppCoordinatorFactory.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

protocol AppCoordinatorFactory {
    
    func makeStarterCoordinator(router: Router) -> Coordinator
}

extension CoordinatorFactory: AppCoordinatorFactory {
    
    func makeStarterCoordinator(router: Router) -> Coordinator {
        StarterCoordinator(router: router, factory: ModuleFactory(router: router), coordinatorFactory: CoordinatorFactory())
    }
}
