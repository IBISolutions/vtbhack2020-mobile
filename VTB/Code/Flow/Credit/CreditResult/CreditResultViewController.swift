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
    
    private let carImageView = UIImageView()
    private let monthlyPaymentsLabel = UILabel()
    private let creditLabel = UILabel()
    private let creditSumLabel = UILabel()
    private lazy var createOfferButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Оформить заявку", for: .normal)
        button.addTarget(self, action: #selector(createOfferAction), for: .touchUpInside)
        return button
    }()
    
    var output: CreditResultControllerOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(createOfferButton)
        createOfferButton.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    @objc private func createOfferAction() {
        output?.didTapOnCreateOffer()
    }
}

extension CreditResultViewController: CreditResultView {
    
}
