//
//  ChooseFlowViewController.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import UIKit
import SnapKit
import VTBUI
import Resources
import Resources

protocol ChooseFlowView: AnyObject {
    
}

final class ChooseFlowViewController: UIViewController {

    private enum Layouts {
        enum Buttons {
            static let insets: CGFloat = 16
            static let bottom: CGFloat = 26
            static let spacing: CGFloat = 18
        }
        enum Car {
            static let ratio: CGFloat = 284 / 192
            static let edges: CGFloat = 48
        }
    }
    
    private lazy var startScanButton: PrimaryButton = {
        let button = PrimaryButton(type: .system)
        button.setTitle("Нажмите чтобы распознать машину", for: .normal)
        button.onTap = {
            [weak self] in
            
            self?.output?.didTapOnStartScan()
        }
        return button
    }()
    
    private lazy var chooseFromGalleryButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.setTitle("Загрузить фото", for: .normal)
        button.onTap = {
            [weak self] in
            
            self?.output?.didTapOnChooseFromGallery()
        }
        return button
    }()
    
    private let backgroundImageView = UIImageView(contentMode: .scaleAspectFill,
                                                  image: R.image.main.background())
    
    private let carImageView = UIImageView(contentMode: .scaleAspectFill,
                                           image: R.image.main.car())
    
    private lazy var bottomButtonsStackView = UIStackView(subviews: [startScanButton, chooseFromGalleryButton],
                                                          axis: .vertical,
                                                          spacing: Layouts.Buttons.spacing)
    
    var output: ChooseFlowControllerOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        view.addSubview(carImageView)
        carImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(carImageView.snp.height).multipliedBy(Layouts.Car.ratio)
            $0.leading.trailing.equalToSuperview().inset(Layouts.Car.edges)
        }
        
        view.addSubview(bottomButtonsStackView)
        bottomButtonsStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Layouts.Buttons.insets)
            $0.bottom.equalToSuperview().inset(Layouts.Buttons.bottom)
        }
    }
}

extension ChooseFlowViewController: ChooseFlowView {
    
}
