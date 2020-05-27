//
//  BuyThird.swift
//  iQube
//
//  Created by Алексей Пархоменко on 27.05.2020.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
import SwiftEntryKit

class NameBuyPaymentAlertView: UIView {

    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let specialtyLabel = UILabel()
    private let actionButton = AlertButton(title: "Оплатить", direction: .right, size: .medium, type: .purple)
    private let canceledButton = AlertButton(title: "Назад", direction: .left, size: .medium, type: .clear)
    
    let model: PriceModel
    
    init(model: PriceModel) {
        self.model = model
        super.init(frame: UIScreen.main.bounds)
        self.priceLabel.text = "\(model.price) руб."
        self.titleLabel.text = model.productName

        setupElements()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func actionButtonPressed() {
        let newView = OrderLinkAlertView()
        transform(to: newView)
    }
    @objc func cancelActionButtonPressed() {
        let newView = NameBuyAlertView(model: model)
        transform(to: newView)
    }
}

// MARK: - Setup View
extension NameBuyPaymentAlertView {
    func setupElements() {

        specialtyLabel.text = "Для оплаты нажмите кнопку ОПЛАТИТЬ. Менеджер свяжется с Вами сразу после заитчсления средств"
        specialtyLabel.numberOfLines = 0
        specialtyLabel.textAlignment = .center
        specialtyLabel.textColor =  #colorLiteral(red: 0.05098039216, green: 0.05490196078, blue: 0.06274509804, alpha: 0.5)
        specialtyLabel.font = UIFont.init(name: "Helvetica", size: 15)

        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        canceledButton.addTarget(self, action: #selector(cancelActionButtonPressed), for: .touchUpInside)

        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.init(name: "Helvetica-Bold", size: 20)
        titleLabel.numberOfLines = 0

        priceLabel.textColor = UIColor(#colorLiteral(red: 0.2549019608, green: 0.03921568627, blue: 0.9137254902, alpha: 1))
        priceLabel.font = UIFont.init(name: "Helvetica", size: 30)
        priceLabel.textAlignment = .center

    }
}


// MARK: - Setup Constraints
extension NameBuyPaymentAlertView {
    func setupConstraints() {

        let stackView = UIStackView(arrangedSubviews: [canceledButton, actionButton], axis: .horizontal, spacing: 12)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        specialtyLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false

        stackView.distribution = .fillEqually
        stackView.alignment = .center

        addSubview(specialtyLabel)
        addSubview(stackView)
        addSubview(priceLabel)
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 33),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
        ])

        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 27),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
        ])

        NSLayoutConstraint.activate([
            specialtyLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 32),
            specialtyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            specialtyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
        ])

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: specialtyLabel.bottomAnchor, constant: 37),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 19),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -19),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            canceledButton.heightAnchor.constraint(equalToConstant: 50),
        ])

        bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 34).isActive = true
    }
}

