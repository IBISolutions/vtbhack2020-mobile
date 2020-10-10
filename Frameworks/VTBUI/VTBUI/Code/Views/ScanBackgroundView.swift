//
//  ScanBackgroundView.swift
//  VTBUI
//
//  Created by viktor.volkov on 10.10.2020.
//

import UIKit
import Resources
import SnapKit

public final class ScanBackgroundView: CustomView {
    
    private enum Layouts {
        enum Shake {
            static let width: CGFloat = 34
        }
        enum Help {
            static let top: CGFloat = 76
        }
    }
    
    private let shakeImageView = UIImageView(contentMode: .scaleAspectFit,
                                             image: R.image.main.shake())
    private let infoLabel = UILabel(lines: .zero,
                                    size: 14,
                                    weight: .medium,
                                    color: .white)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        addSubview(shakeImageView)
        shakeImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(Layouts.Shake.width)
        }
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(shakeImageView.snp.bottom).inset(-Layouts.Help.top)
        }
        infoLabel.text = "Потрясите смартфон для перехода\nв кредитный калькулятор"
        infoLabel.textAlignment = .center
    }
}
