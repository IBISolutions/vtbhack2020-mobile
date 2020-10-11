//
//  CreditCoordinator.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Service
import UIKit

protocol CreditCoordinatorFinishable {
    
    var onFinishFlow: Closure.Void? { get set }
}

final class CreditCoordinator: BaseCoordinator, CreditCoordinatorFinishable {
    
    private let model: Model
    private let factory: CreditModuleFactory
    private let router: Router
    var onFinishFlow: Closure.Void?
    
    init(model: Model, router: Router, factory: CreditModuleFactory) {
        self.model = model
        self.factory = factory
        self.router = router
    }
    
    override func start() {
        showMakeCreditModule()
    }
    
    private func showMakeCreditModule() {
        let (view, output) = factory.makeCreditCalculatorModule(using: model)
        output.onCalculate = {
            [weak self] result in
            
            self?.showCreditResultModule(result: result)
        }
        router.setRootModule(view)
    }
    
    private func showCreditResultModule(result: CalculateResult) {
        let (view, output) = factory.makeCreditResultModule(carName: model.name(),
                                                            photo: model.photo,
                                                            result: result)
        output.onAction = {
            [weak self] action in
            
            switch action {
            case .createOffer:
                self?.showCreditOfferModule(result: result)
            case .schedule:
                self?.showGraphModule(calculateResult: result)
            }
        }
        router.push(view)
    }
    
    private func showCreditOfferModule(result: CalculateResult) {
        let (view, output) = factory.makeCreditOfferModule(car: model,
                                                           calculateResult: result)
        output.onCompleted = {
            [weak self] success in
            
            self?.showAlert(completed: success)
        }
        router.push(view)
    }
    
    private func showGraphModule(calculateResult: CalculateResult) {
        let parameters = PaymentGraphParameters.from(calculate: calculateResult)
        let (view, _) = factory.makeGraphModule(parameters: parameters)
        let controller = UINavigationController(rootViewController: view.toPresent())
        controller.navigationBar.prefersLargeTitles = true
        router.present(controller)
    }
    
    private func showAlert(completed: Bool) {
        if completed {
            showAlert(title: "Поздравляем", message: "Ваша заявка одобрена. Менеджер банка свяжется с вами в ближайшее время для уточнения деталей")
        } else {
            showAlert(title: "Ой...", message: "Ваша заявка не одобрена. Попробуйте изменить кредитные условия или выберите другой автомобиль")
        }
    }
    
    private func showAlert(title: String?, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            [weak self] action in
            
            self?.onFinishFlow?()
        }))
        router.present(alertController, animated: true)
    }
}
