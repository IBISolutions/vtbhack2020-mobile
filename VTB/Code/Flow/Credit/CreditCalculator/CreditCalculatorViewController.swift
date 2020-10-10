//
//  CreditCalculatorViewController.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import UIKit
import VTBUI

protocol CreditCalculatorView: AnyObject {

    
}

final class CreditCalculatorViewController: UIViewController {
    
    private lazy var carImage = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var paymentTitleLabel = UILabel()
    private lazy var paymentValueLabel = UILabel()
    private lazy var paymentSlider = UISlider()
    private lazy var creditTitleLabel = UILabel()
    private lazy var creditValueLabel = UILabel()
    private lazy var creditSlider = UISlider()
    private lazy var cascoCheckbox = UISwitch()
    private lazy var lifeCheckbox = UISwitch()
    private lazy var documentsCheckbox = UISwitch()
    private lazy var calculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(calculateAction), for: .touchUpInside)
        button.setTitle("Рассчитать", for: .normal)
        return button
    }()
    
    private let container = InfiniteContainer()
    
    var output: CreditCalculatorControllerOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(container)
        view.backgroundColor = .white
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        container.setComponentsWithoutEdges([
            carImage,
            titleLabel,
            paymentTitleLabel,
            paymentValueLabel,
            paymentSlider,
            creditTitleLabel,
            creditValueLabel,
            creditSlider,
            cascoCheckbox,
            lifeCheckbox,
            documentsCheckbox,
            calculateButton
        ])
    }
    
    @objc private func calculateAction() {
        output?.didTapOnCalculate()
    }
}

extension CreditCalculatorViewController: CreditCalculatorView {
    
}
