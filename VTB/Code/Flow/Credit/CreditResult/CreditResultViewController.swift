//
//  CreditResultViewController.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import UIKit
import Resources
import VTBUI
import SnapKit

protocol CreditResultView: AnyObject {

    
}

final class CreditResultViewController: UIViewController {
    
    private lazy var carImageView: UIImageView = {
        let image = UIImageView(contentMode: .scaleAspectFit, clipsToBounds: true)
        image.layer.borderWidth = 1
        image.layer.cornerRadius = 8
        image.layer.borderColor = Resources.Color.gray.cgColor
        return image
    }()
    private let monthlyPaymentsLabel = OverallLabel()
    private let creditLabel = OverallLabel()
    private let creditSumLabel = OverallLabel()
    private lazy var createOfferButton: PrimaryButton = {
        let button = PrimaryButton(type: .system)
        button.setTitle("Оформить заявку", for: .normal)
        button.onTap = {
            [weak self] in
            
            self?.output?.didTapOnCreateOffer()
        }
        return button
    }()
    
    private lazy var paymentsButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.setTitle("Получить график платежей", for: .normal)
        button.onTap = {
            [weak self] in
            
            self?.output?.didTapOnPaymentsChart()
        }
        return button
    }()
    
    private lazy var overallsStackView = UIStackView(subviews: [monthlyPaymentsLabel, creditLabel, creditSumLabel],
                                                     axis: .vertical,
                                                     spacing: 40)
    private lazy var buttonsStackView = UIStackView(subviews: [createOfferButton, paymentsButton], axis: .vertical, spacing: 14)
    
    private let container = InfiniteContainer()
    
    var output: CreditResultControllerOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Машина"
        view.backgroundColor = .white
        view.addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(100)
        }
        createOfferButton.snp.makeConstraints { $0.height.equalTo(48) }
        view.addSubview(container)
        container.snp.makeConstraints {
            $0.top.equalToSuperview().inset(48)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(buttonsStackView.snp.top).inset(-16)
        }
        monthlyPaymentsLabel.title = "Ежемесячный платеж"
        monthlyPaymentsLabel.value = "100 000 ₽"
        creditLabel.title = "Ежемесячный платеж"
        creditLabel.value = "100 000 ₽"
        creditSumLabel.title = "Ежемесячный платеж"
        creditSumLabel.value = "100 000 ₽"
        container.setComponents([
            (carImageView, UIEdgeInsets(top: 40, left: 16, bottom: .zero, right: 16)),
            (overallsStackView, UIEdgeInsets(top: 40, left: 16, bottom: .zero, right: 16))
        ])
        carImageView.snp.makeConstraints {
            $0.height.equalTo(206)
            $0.width.equalTo(carImageView.snp.height).multipliedBy(206/343)
        }
    }
    
    @objc private func createOfferAction() {
        output?.didTapOnCreateOffer()
    }
}

extension CreditResultViewController: CreditResultView {
    
}
