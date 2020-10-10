//
//  CreditResultPresenter.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

protocol CreditResultControllerOutput: AnyObject {
    
    func viewDidLoad()
    func didTapOnCreateOffer()
    func didTapOnPaymentsChart()
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
    
    func viewDidLoad() {
        
    }
    
    func didTapOnCreateOffer() {
        onAction?(.createOffer)
    }
    
    func didTapOnPaymentsChart() {
        onAction?(.schedule)
    }
}
