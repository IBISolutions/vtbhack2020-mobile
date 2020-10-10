//
//  + UINavigationController.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import UIKit.UINavigationController

public extension UINavigationController {
    
    func pushViewController(viewController: UIViewController,
                            animated: Bool,
                            completion: Closure.Void?) {
        pushViewController(viewController, animated: animated)
        
        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: nil) {
                _ in
                
                completion?()
            }
        } else {
            completion?()
        }
    }

    func popViewController(animated: Bool,
                           completion: Closure.Void?) -> UIViewController? {
        let controller = popViewController(animated: animated)

        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: nil) {
                _ in
                
                completion?()
            }
        } else {
            completion?()
        }
        
        return controller
    }
}
