//
//  StarterCoordinatorFactory.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import UIKit.UINavigationController
import Service

protocol StarterCoordinatorFactory {
    
    func makeCreditCoordinator(model: Model, rootController: UINavigationController) -> Coordinator & CreditCoordinatorFinishable
}

extension CoordinatorFactory: StarterCoordinatorFactory {
    
    func makeCreditCoordinator(model: Model, rootController: UINavigationController) -> Coordinator & CreditCoordinatorFinishable {
        let router = RouterImp(rootController: rootController)
        return CreditCoordinator(model: model, router: router, factory: ModuleFactory(router: router))
    }
}
