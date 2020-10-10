//
//  + UIViewController.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import UIKit.UIViewController

extension UIViewController {
    
    var lastPresentedController: UIViewController? {
        var lastPresented: UIViewController? = self
        while let last = lastPresented?.presentedViewController {
            lastPresented = last
        }
        return lastPresented
    }
}
