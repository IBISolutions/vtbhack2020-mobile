//
//  ScanPresenter.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

//import Utils

protocol ScanControllerOutput: AnyObject {
    
    func didScan()
}

enum ScanCoordinatorAction {
    case scanned
}

protocol ScanCoordinatorOutput: AnyObject {
    
    var onAction: Closure.Generic<ScanCoordinatorAction>? { get set }
}

final class ScanPresenter {
    
    weak var view: ScanView?
    
    var onAction: Closure.Generic<ScanCoordinatorAction>?

    init(view: ScanView) {
        self.view = view
    }
}

extension ScanPresenter: ScanControllerOutput {
    
    func didScan() {
        onAction?(.scanned)
    }
}

extension ScanPresenter: ScanCoordinatorOutput {
    
}
