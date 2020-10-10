//
//  StarterCoordinatorFactory.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import UIKit.UINavigationController

protocol StarterCoordinatorFactory {
    
    func makeCreditCoordinator(rootController: UINavigationController) -> Coordinator
}

extension CoordinatorFactory: StarterCoordinatorFactory {
    
    func makeCreditCoordinator(rootController: UINavigationController) -> Coordinator {
        let router = RouterImp(rootController: rootController)
        return CreditCoordinator(router: router, factory: ModuleFactory(router: router))
    }
}
