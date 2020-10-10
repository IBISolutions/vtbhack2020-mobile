//
//  ScanViewController.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import UIKit
import SnapKit

protocol ScanView: AnyObject {
    
}

final class ScanViewController: UIViewController {
    
    private lazy var scannedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отсканировал", for: .normal)
        button.addTarget(self, action: #selector(scannedAction), for: .touchUpInside)
        return button
    }()

    var output: ScanControllerOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        view.addSubview(scannedButton)
        scannedButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    @objc private func scannedAction() {
        output?.didScan()
    }
}

extension ScanViewController: ScanView {
    
}
