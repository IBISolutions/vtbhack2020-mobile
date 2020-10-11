//
//  SliderView.swift
//  VTBUI
//
//  Created by viktor.volkov on 11.10.2020.
//

import UIKit
import Resources
import SnapKit

public struct SliderModel {
    
    public let title: String
    public let valueMask: String?
    public let min: SliderBoundary
    public let max: SliderBoundary
    
    public init(title: String, valueMask: String? = nil, min: SliderBoundary, max: SliderBoundary) {
        self.title = title
        self.valueMask = valueMask
        self.min = min
        self.max = max
    }
}

public struct SliderBoundary {
    
    public let title: String
    public let value: Float
    
    public init(title: String, value: Float) {
        self.title = title
        self.value = value
    }
}

public class SliderView: CustomView {
    
    private let titleLabel = UILabel(size: 14, weight: .medium, color: Color.coldGray)
    private let valueLabel = UILabel(size: 16, weight: .medium, color: Color.deepBlack)
    private lazy var slider: CustomSlider = {
        let slider = CustomSlider()
        
        slider.addTarget(self, action: #selector(onChangeSlider), for: .valueChanged)
        return slider
    }()
    private let minValue = UILabel(size: 14, weight: .medium, color: Color.coldGray)
    private let maxValue: UILabel = {
        let label = UILabel(size: 14, weight: .medium, color: Color.coldGray)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var topStackView = UIStackView(subviews: [titleLabel, valueLabel],
                                                axis: .vertical,
                                                spacing: 8)
    private lazy var valueLabelsStackView = UIStackView(subviews: [minValue, maxValue],
                                                        axis: .horizontal,
                                                        spacing: .zero,
                                                        alignment: .fill,
                                                        distribution: .fillEqually)
    private lazy var bottomStackView = UIStackView(subviews: [slider, valueLabelsStackView],
                                                   axis: .vertical,
                                                   spacing: 8)
    private lazy var finiteStackView = UIStackView(subviews: [topStackView, bottomStackView],
                                                   axis: .vertical,
                                                   spacing: 4)
    
    private var valueMask: String?
    
    public var value: Float {
        Float(Int(slider.value))
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(finiteStackView)
        finiteStackView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    public func configure(model: SliderModel) {
        if let mask = model.valueMask {
            valueMask = mask
        }
        titleLabel.text = model.title
        slider.minimumValue = model.min.value
        slider.maximumValue = model.max.value
        slider.value = model.min.value
        minValue.text = String(format: model.min.title, Int(model.min.value))
        maxValue.text = String(format: model.max.title, Int(model.max.value))
        onChangeSlider()
    }
    
    @objc private func onChangeSlider() {
        if let mask = valueMask {
            valueLabel.text = String(format: mask, Int(slider.value))
        } else {
            valueLabel.text = R.string.localizable.pluralYears(years: Int(slider.value))
        }
    }
}

