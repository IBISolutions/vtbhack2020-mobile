//
//  ChooseFlowPresenter.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

protocol ChooseFlowControllerOutput: AnyObject {
    
    func didTapOnStartScan()
}

enum ChooseFlowCoordinatorAction {
    case startScan
}

protocol ChooseFlowCoordinatorOutput: AnyObject {
    
    var onAction: Closure.Generic<ChooseFlowCoordinatorAction>? { get set }
}

final class ChooseFlowPresenter: ChooseFlowCoordinatorOutput {

    weak var view: ChooseFlowView?
    
    var onAction: Closure.Generic<ChooseFlowCoordinatorAction>?

    init(view: ChooseFlowView) {
        self.view = view
    }
}

extension ChooseFlowPresenter: ChooseFlowControllerOutput {
    
    func didTapOnStartScan() {
        onAction?(.startScan)
    }
}
