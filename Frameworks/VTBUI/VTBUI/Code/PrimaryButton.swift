//
//  PrimaryButton.swift
//  VTBUI
//
//  Created by viktor.volkov on 10.10.2020.
//

import UIKit
import Resources

public class CustomButton: UIButton {
    
    public var onTap: (() -> Void)?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        addTarget(self, action: #selector(tapAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tapAction() {
        onTap?()
    }
}

public class PrimaryButton: CustomButton {
    
    private enum Layouts {
        static let height: CGFloat = 48
        static let cornerRadius: CGFloat = 8
    }
    
    public var title: String? {
        didSet {
            setTitle(title, for: .normal)
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        CGSize(width: super.intrinsicContentSize.width, height: Layouts.height)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Color.primaryBlue
        layer.cornerRadius = Layouts.cornerRadius
        setTitleColor(.white, for: .normal)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
