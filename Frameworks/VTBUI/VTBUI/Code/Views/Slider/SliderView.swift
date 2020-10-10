//
//  SliderView.swift
//  VTBUI
//
//  Created by viktor.volkov on 11.10.2020.
//

import UIKit
import Resources
import SnapKit

public struct SliderBoundary {
    
    let title: String
    let value: Float
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
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(finiteStackView)
        finiteStackView.snp.makeConstraints { $0.edges.equalToSuperview() }
        configure(title: "Первоначальный взнос", value: "800000", min: SliderBoundary(title: "800 000 Р", value: 800_000), max: SliderBoundary(title: "1 600 000 Р", value: 1_600_000))
    }
    
    public func configure(title: String, value: String, min: SliderBoundary, max: SliderBoundary) {
        titleLabel.text = title
        valueLabel.text = String(format: "%d", Int(slider.value))
        minValue.text = min.title
        slider.minimumValue = min.value
        maxValue.text = max.title
        slider.maximumValue = max.value
    }
    
    @objc private func onChangeSlider() {
        valueLabel.text = String(format: "%d", Int(slider.value))
    }
}

