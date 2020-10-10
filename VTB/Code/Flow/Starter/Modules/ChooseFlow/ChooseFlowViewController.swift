//
//  ChooseFlowViewController.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import UIKit
import SnapKit

protocol ChooseFlowView: AnyObject {
    
}

final class ChooseFlowViewController: UIViewController {

    
    private lazy var startScanButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Шазамь", for: .normal)
        button.addTarget(self, action: #selector(startScanningAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var chooseFromGalleryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Из галереи", for: .normal)
        button.addTarget(self, action: #selector(chooseFromGalleryAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var bottomButtonsStackView = UIStackView(subviews: [startScanButton, chooseFromGalleryButton], axis: .vertical, spacing: 24)
    
    var output: ChooseFlowControllerOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        view.addSubview(bottomButtonsStackView)
        bottomButtonsStackView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc private func startScanningAction() {
        output?.didTapOnStartScan()
    }
    
    @objc private func chooseFromGalleryAction() {
        output?.didTapOnChooseFromGallery()
    }
}

extension ChooseFlowViewController: ChooseFlowView {
    
}
