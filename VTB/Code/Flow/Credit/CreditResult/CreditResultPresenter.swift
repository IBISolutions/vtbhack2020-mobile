//
//  CreditResultPresenter.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

protocol CreditResultControllerOutput: AnyObject {
    
    func didTapOnCreateOffer()
}

enum CreditResultCoordinatorAction {
    case createOffer, schedule
}

protocol CreditResultCoordinatorOutput: AnyObject {
    
    var onAction: Closure.Generic<CreditResultCoordinatorAction>? { get set }
}

final class CreditResultPresenter: CreditResultCoordinatorOutput {

    weak var view: CreditResultView?
    
    var onAction: Closure.Generic<CreditResultCoordinatorAction>?

    init(view: CreditResultView) {
        self.view = view
    }
}

extension CreditResultPresenter: CreditResultControllerOutput {
    
    func didTapOnCreateOffer() {
        onAction?(.createOffer)
    }
}
