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
    
    func configure(with title: String,
                   photo: String,
                   paymentsSliderModel: SliderModel,
                   creditSliderModel: SliderModel,
                   conditions: [SpecialConditions]?)
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
            
            self?.collectDataAndSend()
        }
        button.setTitle("Рассчитать", for: .normal)
        return button
    }()
    
    private let container = InfiniteContainer()
    
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
            $0.bottom.equalTo(calculateButton.snp.top).offset(-16)
        }
        view.bringSubviewToFront(calculateButton)
        carImageView.snp.makeConstraints {
            $0.height.equalTo(206)
            $0.width.equalTo(carImageView.snp.height).multipliedBy(206/343)
        }
        output?.viewDidLoad()
    }
    
    private func collectDataAndSend() {
        let paymentValue = paymentSlider.value
        let creditValue = creditSlider.value
        let selectedIds = checkboxesContainer.arrangedSubviews.map {
            view -> String? in
            
            guard let checkbox = view as? Checkbox else {
                return nil
            }
            return checkbox.isChecked ? checkbox.id : nil
        }.compactMap { $0 }
        output?.didTapOnCalculate(paymentValue: paymentValue,
                                  creditValue: creditValue,
                                  conditions: selectedIds)
    }
}

extension CreditCalculatorViewController: CreditCalculatorView {
    
    func configure(with title: String,
                   photo: String,
                   paymentsSliderModel: SliderModel,
                   creditSliderModel: SliderModel,
                   conditions: [SpecialConditions]?) {
        self.title = title
        guard let url = URL(string: photo) else {
            return
        }
        carImageView.kf.setImage(with: url)
        paymentSlider.configure(model: paymentsSliderModel)
        creditSlider.configure(model: creditSliderModel)
        guard let conditions = conditions else {
            return
        }
        conditions.map {
            condition in
            
            let checkbox = Checkbox()
            checkbox.id = condition.id
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
        container.removeAll()
        container.setComponents([
            (carImageView, UIEdgeInsets(top: 40, left: 16, bottom: .zero, right: 16)),
            (paymentSlider, UIEdgeInsets(top: 24, left: 16, bottom: .zero, right: 16)),
            (creditSlider, UIEdgeInsets(top: 20, left: 16, bottom: .zero, right: 16)),
            (checkboxesContainer, UIEdgeInsets(top: 38, left: 16, bottom: 16, right: 16))
        ])
    }
}
