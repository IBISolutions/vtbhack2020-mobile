//
//  GraphPresenter.swift
//  VTB
//
//  Created by viktor.volkov on 11.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Service

protocol GraphControllerOutput: AnyObject {
    
    func viewDidLoad()
}

protocol GraphCoordinatorOutput: AnyObject {


}

final class GraphPresenter {

    weak var view: GraphView?
    private let parameters: PaymentGraphParameters
    private let service = NetworkService()

    init(parameters: PaymentGraphParameters, view: GraphView) {
        self.parameters = parameters
        self.view = view
    }
}

extension GraphPresenter: GraphControllerOutput {
    
    func viewDidLoad() {
        service.paymentGraph(using: parameters) {
            [weak self] res in
            
            if case .success(let res) = res {
                self?.view?.showData(payments: res.payments)
            }
        }
    }
}

extension GraphPresenter: GraphCoordinatorOutput {
    
}
