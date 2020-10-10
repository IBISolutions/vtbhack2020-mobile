//
//  Checkbox.swift
//  VTBUI
//
//  Created by viktor.volkov on 11.10.2020.
//

import UIKit
import Resources

public class Checkbox: CustomButton {
    
    private enum Constants {
        enum State {
            static let selected = R.image.uI.checkbox.selected()
            static let deselected = R.image.uI.checkbox.deselected()
        }
    }
    
    public var isChecked: Bool = false {
        didSet {
            if isChecked {
                setImage(Constants.State.selected, for: UIControl.State.normal)
            } else {
                setImage(Constants.State.deselected, for: UIControl.State.normal)
            }
        }
    }
    
    public var title: String? {
        didSet {
            setTitle(title, for: .normal)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        onTap = {
            [weak self] in
            
            self?.isChecked.toggle()
        }
        titleEdgeInsets = UIEdgeInsets(top: .zero, left: 8, bottom: .zero, right: -8)
        setImage(Constants.State.deselected, for: UIControl.State.normal)
        setTitleColor(Color.deepBlack, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onToggle() {
        isChecked.toggle()
    }
}

