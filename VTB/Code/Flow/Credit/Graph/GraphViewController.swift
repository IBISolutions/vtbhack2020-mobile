//
//  GraphViewController.swift
//  VTB
//
//  Created by viktor.volkov on 11.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import UIKit
import Resources
import SnapKit
import VTBUI
import Service

protocol GraphView: AnyObject {
    
    func showData(payments: [Payment])
}

final class GraphViewController: UIViewController {
    
    private var payments: [Payment] = []

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(GraphTableViewCell.self, forCellReuseIdentifier: "GraphTableViewCell")
        return tableView
    }()
    var output: GraphControllerOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "График платежей"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                            target: self,
                                                            action: #selector(closeAction))
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        tableView.reloadData()
        output?.viewDidLoad()
    }
    
    @objc private func closeAction() {
        dismiss(animated: true)
    }
}

extension GraphViewController: GraphView {
    
    func showData(payments: [Payment]) {
        self.payments = payments
        tableView.reloadData()
    }
}

extension GraphViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = GraphTableViewContent.dark()
        view.configure(order: "№", payment: "Платеж", debt: "Долг", percent: "Процент", balance: "Остаток")
        return view
    }
}

extension GraphViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GraphTableViewCell") as? GraphTableViewCell else {
            fatalError()
        }
        let payment = payments[indexPath.row]
        cell.configure(order: "\(payment.order)",
                       payment: "\(payment.payment)",
                       debt: "\(payment.debt)",
                       percent: "\(payment.percent)",
                       balance: "\(payment.balanceOut)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payments.count
    }
}
