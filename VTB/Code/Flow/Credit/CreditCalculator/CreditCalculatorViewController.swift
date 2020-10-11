//
//  CreditCalculatorViewController.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import UIKit
import Resources
import Service
import VTBUI
import Kingfisher

protocol CreditCalculatorView: AnyObject {
    
    func configure(with model: Model, conditions: [SpecialConditions]?)
}

final class CreditCalculatorViewController: UIViewController {
    
    private lazy var carImageView: UIImageView = {
        let image = UIImageView(contentMode: .scaleAspectFit, clipsToBounds: true)
        image.layer.borderWidth = 1
        image.layer.cornerRadius = 8
        image.layer.borderColor = Resources.Color.gray.cgColor
        return image
    }()
    private lazy var paymentSlider = SliderView()
    private lazy var creditSlider = SliderView()
    private lazy var cascoCheckbox: Checkbox = {
        let checkbox = Checkbox()
        checkbox.title = "КАСКО"
        return checkbox
    }()
    private lazy var lifeCheckbox: Checkbox = {
        let checkbox = Checkbox()
        checkbox.title = "Страхование жизни"
        return checkbox
    }()
    private lazy var documentsCheckbox: Checkbox = {
        let checkbox = Checkbox()
        checkbox.title = "Полный пакет документов"
        return checkbox
    }()
    private lazy var calculateButton: PrimaryButton = {
        let button = PrimaryButton(type: .system)
        button.onTap = {
            [weak self] in
            
            self?.output?.didTapOnCalculate()
        }
        button.setTitle("Рассчитать", for: .normal)
        return button
    }()
    
    private let container: InfiniteContainer = {
        let container = InfiniteContainer()
        return container
    }()
    
    private lazy var checkboxesContainer = UIStackView(subviews: [],
                                                       axis: .vertical,
                                                       spacing: 34,
                                                       alignment: .leading)
    
    var output: CreditCalculatorControllerOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        view.addSubview(calculateButton)
        calculateButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        
        view.addSubview(container)
        container.snp.makeConstraints {
            $0.top.equalToSuperview().inset(48)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(calculateButton.snp.top).inset(-16)
        }
        container.setComponents([
            (carImageView, UIEdgeInsets(top: 40, left: 16, bottom: .zero, right: 16)),
            (paymentSlider, UIEdgeInsets(top: 24, left: 16, bottom: .zero, right: 16)),
            (creditSlider, UIEdgeInsets(top: 20, left: 16, bottom: .zero, right: 16)),
        ])
        view.bringSubviewToFront(calculateButton)
        carImageView.snp.makeConstraints {
            $0.height.equalTo(206)
            $0.width.equalTo(carImageView.snp.height).multipliedBy(206/343)
        }
        output?.viewDidLoad()
    }
    
    @objc private func calculateAction() {
        output?.didTapOnCalculate()
    }
}

extension CreditCalculatorViewController: CreditCalculatorView {
    
    func configure(with model: Model, conditions: [SpecialConditions]?) {
        title = model.title
        guard let url = URL(string: model.photo) else {
            return
        }
        carImageView.kf.setImage(with: url)
        guard let conditions = conditions else {
            return
        }
        conditions.map {
            condition in
            
            let checkbox = Checkbox()
            //HACK
            if condition.name.contains("Я готов предоставить") {
                checkbox.title = "Полный пакет документов"
            } else {
                checkbox.title = condition.name
            }
            return checkbox
        }.forEach {
            checkboxesContainer.addArrangedSubview($0)
        }
        container.addComponent(checkboxesContainer, with: UIEdgeInsets(top: 38,
                                                                       left: 16,
                                                                       bottom: .zero,
                                                                       right: 16))
    }
}
