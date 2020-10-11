//
//  TextFieldView.swift
//  VTBUI
//
//  Created by viktor.volkov on 11.10.2020.
//

import UIKit
import Resources

public class TextFieldView: CustomView {
    
    private enum Layouts {
        static let height: CGFloat = 70
    }
    
    private let titleLabel = UILabel(size: 14, weight: .medium, color: Color.primaryBlue)
    private let textField = UITextField()
    private let lineView = UIView(backgroundColor: Color.primaryBlue)
    
    public var value: String {
        textField.text ?? ""
    }
    
    public override var intrinsicContentSize: CGSize {
        CGSize(width: super.intrinsicContentSize.width, height: Layouts.height)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
        }
        addSubview(textField)
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.width.equalToSuperview()
        }
        addSubview(lineView)
        lineView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(4)
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    public func configure(title: String, placholder: String? = nil, keyboardType: UIKeyboardType = .default) {
        titleLabel.text = title
        textField.keyboardType = keyboardType
        textField.placeholder = placholder
    }
}
