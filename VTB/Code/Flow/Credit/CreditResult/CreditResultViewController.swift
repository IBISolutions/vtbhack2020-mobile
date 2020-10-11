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
    
    func configure(with title: String,
                   photo: String,
                   monthlyPaymentsModel: OverallModel,
                   creditModel: OverallModel,
                   creditSumModel: OverallModel,
                   termModel: OverallModel)
}

final class CreditResultViewController: UIViewController {
    
    private enum Layouts {
        static let insets = UIEdgeInsets(top: 40, left: 16, bottom: .zero, right: 16)
    }
    
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
    private let termLabel = OverallLabel()
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
    
    private lazy var buttonsStackView = UIStackView(subviews: [createOfferButton, paymentsButton],
                                                    axis: .vertical,
                                                    spacing: 4)
    
    private let container = InfiniteContainer()
    
    var output: CreditResultControllerOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .automatic
        view.backgroundColor = .white
        view.addSubview(container)
        
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        carImageView.snp.makeConstraints {
            $0.height.equalTo(206)
            $0.width.equalTo(carImageView.snp.height).multipliedBy(206/343)
        }
        container.setComponents([
            (carImageView, Layouts.insets),
            (monthlyPaymentsLabel, Layouts.insets),
            (creditLabel, Layouts.insets),
            (creditSumLabel, Layouts.insets),
            (termLabel, Layouts.insets),
            (createOfferButton, UIEdgeInsets(top: 40, left: 16, bottom: .zero, right: 16)),
            (paymentsButton, UIEdgeInsets(top: 4, left: 16, bottom: 16, right: 16)),
        ])
        output?.viewDidLoad()
    }
    
    @objc private func createOfferAction() {
        output?.didTapOnCreateOffer()
    }
}

extension CreditResultViewController: CreditResultView {
    
    func configure(with title: String,
                   photo: String,
                   monthlyPaymentsModel: OverallModel,
                   creditModel: OverallModel,
                   creditSumModel: OverallModel,
                   termModel: OverallModel) {
        self.title = title
        guard let url = URL(string: photo) else {
            return
        }
        carImageView.kf.setImage(with: url)
        monthlyPaymentsLabel.configure(with: monthlyPaymentsModel)
        creditLabel.configure(with: creditModel)
        creditSumLabel.configure(with: creditSumModel)
        termLabel.configure(with: termModel)
    }
}
