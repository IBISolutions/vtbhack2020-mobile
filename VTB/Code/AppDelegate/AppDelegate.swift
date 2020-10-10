//
//  AppDelegate.swift
//  VTB
//
//  Created by viktor.volkov on 09.10.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var rootViewController = UINavigationController()
    private lazy var appCoordinator = self.makeAppCoordinator()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        appCoordinator.start()
        return true
    }
    
    private func makeAppCoordinator() -> Coordinator {
        let router = RouterImp(rootController: rootViewController)
        return AppCoordinator(router: router,
                              coordinatorFactory: CoordinatorFactory(),
                              moduleFactory: ModuleFactory(router: router))
    }
}

