//
//  CreditOfferPresenter.swift
//  VTB
//
//  Created by viktor.volkov on 11.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

protocol CreditOfferControllerOutput: AnyObject {
    
    func didTapOnSend()
}

protocol CreditOfferCoordinatorOutput: AnyObject {

}

final class CreditOfferPresenter {

    weak var view: CreditOfferView?

    init(view: CreditOfferView) {
        self.view = view
    }
}

extension CreditOfferPresenter: CreditOfferControllerOutput {
    
    func didTapOnSend() {
        
    }
}

extension CreditOfferPresenter: CreditOfferCoordinatorOutput {
    
}
