//
//  BaseCoordinator.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Foundation

class BaseCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    func start() {
        fatalError("Should be overriden")
    }
    // add only unique object
    func addDependency(_ coordinator: Coordinator?) {
        guard let coordinator = coordinator, !childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator
            else { return }
        
        // Clear child-coordinators recursively
        if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators
                .filter { $0 !== coordinator }
                .forEach { coordinator.removeDependency($0) }
        }
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
    
    func removeChildCoordinators() {
        childCoordinators.forEach(removeDependency)
    }
    
    func removeChildrensDependencies() {
        childCoordinators.forEach {
            childCoordinator in
            
            if let coordinator = childCoordinator as? BaseCoordinator {
                coordinator.childCoordinators.forEach(coordinator.removeDependency)
            }
        }
    }
}
