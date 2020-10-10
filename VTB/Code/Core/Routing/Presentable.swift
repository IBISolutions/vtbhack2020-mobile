//
//  Presentable.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import UIKit.UIViewController

protocol Presentable {
    
    func toPresent() -> UIViewController
}

extension UIViewController: Presentable {
    
    func toPresent() -> UIViewController {
        return self
    }
}
