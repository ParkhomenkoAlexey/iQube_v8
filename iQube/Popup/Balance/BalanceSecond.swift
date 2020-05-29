//
//  BalanceSecond.swift
//  iQube
//
//  Created by Алексей Пархоменко on 29.05.2020.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
import SwiftEntryKit

class BalanceEnterAlertView: UIView {

    private let imageView = UIImageView()
    private let specialtyLabel = UILabel()
    private let textFeild = UITextField()
    private let actionButton = AlertButton(title: "Пополнить", direction: .right, size: .medium, type: .purple)
    private let canceledButton = AlertButton(title: "Назад", direction: .left, size: .medium, type: .clear)
    private var userName = String()
    let item: ItemModel

    init(item: ItemModel) {
        self.item = item
        super.init(frame: UIScreen.main.bounds)
        self.userName = item.text

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
        let newView = BalanceStartAlertView(item: item)
        transform(to: newView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
}

// MARK: - Setup View
extension BalanceEnterAlertView {
    func setupElements() {
        
        imageView.image = UIImage(named: "pocket")
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 8

        textFeild.layer.cornerRadius = 25

        specialtyLabel.text = "Введите сумму для зачисления:"
        specialtyLabel.numberOfLines = 0
        specialtyLabel.textAlignment = .center
        specialtyLabel.textColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        specialtyLabel.font = UIFont.init(name: "Helvetica", size: 20)

        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        canceledButton.addTarget(self, action: #selector(cancelActionButtonPressed), for: .touchUpInside)

        textFeild.backgroundColor = #colorLiteral(red: 0.9362768531, green: 0.9414058924, blue: 0.9454447627, alpha: 0.5368150685)
        textFeild.textAlignment = .center
        textFeild.font = UIFont.init(name: "Helvetica", size: 20)
        textFeild.textColor = #colorLiteral(red: 0.05098039216, green: 0.05490196078, blue: 0.06274509804, alpha: 0.5)

    }
}


// MARK: - Setup Constraints
extension BalanceEnterAlertView {
    func setupConstraints() {

        let stackView = UIStackView(arrangedSubviews: [canceledButton, actionButton], axis: .horizontal, spacing: 9)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        specialtyLabel.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        textFeild.translatesAutoresizingMaskIntoConstraints = false

        stackView.distribution = .fillEqually
        stackView.alignment = .center

        addSubview(imageView)
        addSubview(specialtyLabel)
        addSubview(textFeild)
        addSubview(stackView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 43),
            imageView.heightAnchor.constraint(equalToConstant: 71),
            imageView.widthAnchor.constraint(equalToConstant: 90),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 131),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -131),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            specialtyLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 23),
            specialtyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 73),
            specialtyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -73),

        ])

        NSLayoutConstraint.activate([
            textFeild.topAnchor.constraint(equalTo: specialtyLabel.bottomAnchor, constant: 30),
            textFeild.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            textFeild.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            textFeild.heightAnchor.constraint(equalToConstant: 55)
        ])

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: textFeild.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            canceledButton.heightAnchor.constraint(equalToConstant: 50),
        ])

        bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 34).isActive = true
    }
}

