//
//  GraphTableViewCell.swift
//  VTBUI
//
//  Created by viktor.volkov on 11.10.2020.
//

import UIKit
import SnapKit
import Resources

public class GraphTableViewContent: CustomView {
    
    public static func light() -> GraphTableViewContent {
        GraphTableViewContent()
    }
    
    public static func dark() -> GraphTableViewContent {
        let view = GraphTableViewContent()
        view.backgroundColor = Color.coldGray
        return view
    }
    
    private lazy var orderLabel = createLabel()
    private lazy var paymentLabel = createLabel()
    private lazy var debtLabel = createLabel()
    private lazy var percentLabel = createLabel()
    private lazy var balanceLabel = createLabel()
    
    private lazy var stackView = UIStackView(subviews: [orderLabel, paymentLabel, debtLabel, percentLabel, balanceLabel],
                                             axis: .horizontal,
                                             spacing: .zero,
                                             distribution: .fillEqually)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }
    
    public func configure(order: String, payment: String, debt: String, percent: String, balance: String) {
        orderLabel.text = order
        paymentLabel.text = payment
        debtLabel.text = debt
        percentLabel.text = percent
        balanceLabel.text = balance
    }
}

public class GraphTableViewCell: UITableViewCell {
    
    private let graphView = GraphTableViewContent.light()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(graphView)
        graphView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(order: String, payment: String, debt: String, percent: String, balance: String) {
        graphView.configure(order: order, payment: payment, debt: debt, percent: percent, balance: balance)
    }
}
