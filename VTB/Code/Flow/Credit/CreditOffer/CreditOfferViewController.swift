//
//  CreditOfferViewController.swift
//  VTB
//
//  Created by viktor.volkov on 11.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import UIKit
import Resources
import VTBUI
import SnapKit

protocol CreditOfferView: AnyObject { }

final class CreditOfferViewController: UIViewController {
    
    private lazy var emailTextFieldView: TextFieldView = {
        let textFieldView = TextFieldView()
        textFieldView.configure(title: "E-mail")
        return textFieldView
    }()
    private lazy var familyTextFieldView: TextFieldView = {
        let textFieldView = TextFieldView()
        textFieldView.configure(title: "Фамилия")
        return textFieldView
    }()
    private lazy var nameTextFieldView: TextFieldView = {
        let textFieldView = TextFieldView()
        textFieldView.configure(title: "Имя")
        return textFieldView
    }()
    private lazy var secondNameTextFieldView: TextFieldView = {
        let textFieldView = TextFieldView()
        textFieldView.configure(title: "Отчество")
        return textFieldView
    }()
    private lazy var phoneTextFieldView: TextFieldView = {
        let textFieldView = TextFieldView()
        textFieldView.configure(title: "Телефон")
        return textFieldView
    }()
    private lazy var cityTextFieldView: TextFieldView = {
        let textFieldView = TextFieldView()
        textFieldView.configure(title: "Город")
        return textFieldView
    }()
    private lazy var birthdayTextFieldView: TextFieldView = {
        let textFieldView = TextFieldView()
        textFieldView.configure(title: "Дата рождения")
        return textFieldView
    }()
    private lazy var textFieldsStack: UIStackView = {
        let subviews = [
            emailTextFieldView,
            familyTextFieldView,
            nameTextFieldView,
            secondNameTextFieldView,
            phoneTextFieldView,
            cityTextFieldView,
            birthdayTextFieldView
        ]
        return UIStackView(subviews: subviews, axis: .vertical, spacing: 24)
    }()
    
    private lazy var sendButton: PrimaryButton = {
        let button = PrimaryButton()
        button.title = "Отправить"
        button.onTap = {
            [weak self] in
            
            self?.collectDataAndSend()
        }
        return button
    }()
    private let container = InfiniteContainer()
    private var bottomConstraint: Constraint?
    var output: CreditOfferControllerOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        title = "Заявка на автокредит"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onViewTap))
        view.addGestureRecognizer(tapGesture)
        view.addSubview(container)
        view.addSubview(sendButton)
        sendButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
            self.bottomConstraint = $0.bottom.equalToSuperview().offset(-16).constraint
        }
        container.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(sendButton.snp.top).offset(-16)
        }
        container.setComponents([
            (textFieldsStack, UIEdgeInsets(top: 28, left: 16, bottom: 16, right: 16))
        ])
        NotificationCenter.default.addObserver(self,
               selector: #selector(self.keyboardNotification(notification:)),
               name: UIResponder.keyboardWillChangeFrameNotification,
               object: nil)
        view.bringSubviewToFront(sendButton)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let endFrameY = endFrame?.origin.y ?? 0
        let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        if endFrameY >= UIScreen.main.bounds.size.height {
            bottomConstraint?.layoutConstraints.first?.constant = -16
        } else {
            bottomConstraint?.layoutConstraints.first?.constant = -(endFrame?.size.height ?? 0) - 16
        }
        
        UIView.animate(withDuration: duration,
                       delay: TimeInterval(0),
                       options: animationCurve,
                       animations: { self.view.layoutIfNeeded() },
                       completion: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func onViewTap() {
        view.endEditing(true)
    }
    
    private func collectDataAndSend() {
        output?.didTapOnSend(email: emailTextFieldView.value,
                             family: familyTextFieldView.value,
                             name: nameTextFieldView.value,
                             secondName: secondNameTextFieldView.value,
                             phone: phoneTextFieldView.value,
                             city: cityTextFieldView.value,
                             birthday: birthdayTextFieldView.value)
    }
}

extension CreditOfferViewController: CreditOfferView { }
