//
//  RouterImp.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Foundation
import UIKit

final class RouterImp: NSObject, Router {
    
    weak var rootController: UINavigationController?
    private var completions: [UIViewController : () -> Void]
    
    private var lastPresentedController: UIViewController? {
        rootController?.lastPresentedController
    }
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
        completions = [:]
    }
    
    func toPresent() -> UIViewController {
        return rootController ?? UIViewController()
    }
    
    func pushUp(_ module: Presentable, animated: Bool, modalPresentationStyle: UIModalPresentationStyle, completion: (() -> Void)?) {
        let toPresent = module.toPresent()
        module.toPresent().modalPresentationCapturesStatusBarAppearance = true
        toPresent.modalPresentationStyle = modalPresentationStyle
        lastPresentedController?.present(toPresent, animated: animated, completion: completion)
    }
    
    func popDown(animated: Bool, completion: (() -> Void)?) {
        lastPresentedController?.dismiss(animated: animated, completion: completion)
    }
    
    func present(_ module: Presentable,
                 animated: Bool,
                 modalPresentationStyle: UIModalPresentationStyle) {
        module.toPresent().modalPresentationStyle = modalPresentationStyle
        rootController?.present(module.toPresent(), animated: animated, completion: nil)
    }
    
    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }
    
    func push(_ module: Presentable,
              animated: Bool,
              hideBottomBar: Bool,
              isSwipeToBackEnabled: Bool,
              forceSwipeToBackEnabled: Bool,
              completion: (() -> Void)?,
              animationCompletion: Closure.Void? = nil) {

        let controller = module.toPresent()
        
        if controller is UINavigationController == true {
            assertionFailure("Deprecated push UINavigationController.")
            return
        }
        
        if let completion = completion {
            completions[controller] = completion
        }

        controller.hidesBottomBarWhenPushed = hideBottomBar
        rootController?.pushViewController(viewController: controller,
                                           animated: animated) {
            animationCompletion?()
        }
    }
    
    func popModule(animated: Bool,
                   animationCompletion: Closure.Void? = nil) {
        let optionalController = rootController?.popViewController(animated: animated) {
            animationCompletion?()
        }
        if let controller = optionalController {
            runCompletion(for: controller)
        }
    }
    
    func popBack<ControllerType: UIViewController>(toControllerType: ControllerType.Type) {
        rootController?.viewControllers.reversed().forEach {
            if $0.isKind(of: toControllerType) {
                self.rootController?.popToViewController($0, animated: true)
                return
            }
        }
    }
    
    func popBack(toControllerOfTypes types: [UIViewController.Type]) {
        rootController?.viewControllers.reversed().forEach {
            controller in
            
            if types.contains(where: { controller.isKind(of: $0) }) {
                self.rootController?.popToViewController(controller, animated: true)
                return
            }
        }
    }
    
    func popToModule(vc: UIViewController, animated: Bool) {
        if let controllers = rootController?.popToViewController(vc, animated: animated) {
            controllers.forEach { runCompletion(for: $0) }
        }
    }
    
    func setRootModule(_ module: Presentable, hideBar: Bool) {
        
        rootController?.setViewControllers([module.toPresent()], animated: false)
        rootController?.isNavigationBarHidden = hideBar
    }
    
    func popToRootModule(animated: Bool) {
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach {
                controller in
                
                runCompletion(for: controller)
            }
        }
    }
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else {
            return
        }
        
        completion()
        completions.removeValue(forKey: controller)
    }
    
    func replaceLastModule(_ module: Presentable, animated: Bool = true) {
        guard let rootController = rootController else {
            return
        }
        
        var controllers = rootController.viewControllers
        controllers.removeLast()
        controllers.append(module.toPresent())
        rootController.setViewControllers(controllers, animated: animated)
    }
}
