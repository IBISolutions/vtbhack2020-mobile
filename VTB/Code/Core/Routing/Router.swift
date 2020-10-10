//
//  Router.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Foundation

import Foundation
import SafariServices

protocol Router: Presentable {
    
    var rootController: UINavigationController? { get }
    
    func pushUp(_ module: Presentable,
                animated: Bool,
                modalPresentationStyle: UIModalPresentationStyle,
                completion: Closure.Void?)
    
    func popDown(animated: Bool, completion: Closure.Void?)
    func popDownAll(animated: Bool, completion: Closure.Void?)
    
    func present(_ module: Presentable,
                 animated: Bool,
                 modalPresentationStyle: UIModalPresentationStyle)
    
    func push(_ module: Presentable,
              animated: Bool,
              hideBottomBar: Bool,
              isSwipeToBackEnabled: Bool,
              forceSwipeToBackEnabled: Bool,
              completion: Closure.Void?,
              animationCompletion: Closure.Void?)

    func popModule(animated: Bool)
    func popModule(animated: Bool, animationCompletion: Closure.Void?)
    
    func popBack<ControllerType: UIViewController>(toControllerType: ControllerType.Type)
    
    func popBack(toControllerOfTypes: [UIViewController.Type])
    
    func popToModule(vc: UIViewController, animated: Bool)
    
    func dismissModule(animated: Bool, completion: Closure.Void?)
    
    func setRootModule(_ module: Presentable, hideBar: Bool)
    
    func popToRootModule(animated: Bool)
    
    func replaceLastModule(_ module: Presentable, animated: Bool)
}

extension Router {
    
    func pushUp(_ module: Presentable,
                animated: Bool = true,
                modalPresentationStyle: UIModalPresentationStyle = .overFullScreen,
                completion: Closure.Void? = nil) {
        pushUp(module, animated: animated, modalPresentationStyle: modalPresentationStyle, completion: completion)
    }
    
    func popDown(animated: Bool) {
        popDown(animated: animated, completion: nil)
    }
    
    func popDown() {
        popDown(animated: true, completion: nil)
    }
    
    func popDown(completion: Closure.Void?) {
        popDown(animated: true, completion: completion)
    }
    
    func popDownAll(animated: Bool, completion: Closure.Void?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }
    
    func popDownAll() {
        popDownAll(animated: true, completion: nil)
    }
    
    func present(_ module: Presentable,
                 animated: Bool = true,
                 modalPresentationStyle: UIModalPresentationStyle = .overFullScreen) {
        present(module,
                animated: animated,
                modalPresentationStyle: modalPresentationStyle)
    }

    func push(_ module: Presentable,
              animated: Bool = true,
              hideBottomBar: Bool = false,
              isSwipeToBackEnabled: Bool = true,
              forceSwipeToBackEnabled: Bool = true,
              completion: Closure.Void? = nil) {

        push(module,
             animated: animated,
             hideBottomBar: hideBottomBar,
             isSwipeToBackEnabled: isSwipeToBackEnabled,
             forceSwipeToBackEnabled: forceSwipeToBackEnabled,
             completion: completion,
             animationCompletion: nil)
    }
    
    func popModule() {
        popModule(animated: true, animationCompletion: nil)
    }
    
    func popModule(animated: Bool) {
        popModule(animated: animated, animationCompletion: nil)
    }
    
    func popToModule(vc: UIViewController) {
        popToModule(vc: vc, animated: true)
    }
    
    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }
    
    func setRootModule(_ module: Presentable) {
        setRootModule(module, hideBar: false)
    }
}
