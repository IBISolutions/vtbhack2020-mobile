//
//  OverallLabel.swift
//  VTBUI
//
//  Created by viktor.volkov on 11.10.2020.
//

import UIKit
import Resources
import SnapKit

public struct OverallModel {
    
    let title: String
    let value: String
    
    public init(title: String, value: String) {
        self.title = title
        self.value = value
    }
}

public class OverallLabel: CustomView {
    
    private let titleLabel = UILabel(size: 18, weight: .semibold, color: Color.coldGray)
    private let valueLabel = UILabel(size: 28, weight: .bold, color: Color.deepBlack)
    private lazy var stackView = UIStackView(subviews: [titleLabel, valueLabel],
                                             axis: .vertical,
                                             spacing: 8)
    
    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var value: String? {
        didSet {
            valueLabel.text = value
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stackView)
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    public func configure(with model: OverallModel) {
        title = model.title
        value = model.value
    }
}
