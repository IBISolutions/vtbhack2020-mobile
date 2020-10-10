//
//  StarterModuleFactory.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

protocol StarterModuleFactory {
    
    func makeChooseFlow() -> (Presentable, ChooseFlowCoordinatorOutput)
    func makeScannerModule() -> (Presentable, ScanCoordinatorOutput)
}

extension ModuleFactory: StarterModuleFactory {
    
    func makeChooseFlow() -> (Presentable, ChooseFlowCoordinatorOutput) {
        let controller = ChooseFlowViewController()
        let presenter = ChooseFlowPresenter(view: controller)
        controller.output = presenter
        return (controller, presenter)
    }
    
    func makeScannerModule() -> (Presentable, ScanCoordinatorOutput) {
        let controller = ScanViewController()
        let presenter = ScanPresenter(view: controller)
        controller.output = presenter
        return (controller, presenter)
    }
}
