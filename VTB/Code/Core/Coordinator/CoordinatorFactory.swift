//
//  CoordinatorFactory.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import UIKit.UINavigationController

final class CoordinatorFactory {
    
    func createRouter(_ navController: UINavigationController) -> Router {
        return RouterImp(rootController: navController)
    }
}
