//
//  BalanceFirst.swift
//  iQube
//
//  Created by Алексей Пархоменко on 29.05.2020.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
import SwiftEntryKit

class BalanceStartAlertView: UIView {

    private let imageView = UIImageView()
    private let specialtyLabel = UILabel()
    private let balancedLabel = UILabel()
    private let actionButton = AlertButton(title: "Пополнить", direction: .right, size: .large, type: .purple)
    private var userName = String()
    let item: ItemModel

    init(item: ItemModel) {
        self.item = item
        super.init(frame: UIScreen.main.bounds)
        self.userName = item.text
        self.balancedLabel.text = "(\(item.value ?? 6666) руб.)"
        
        if !item.color.isEmpty {
            actionButton.backgroundColor = UIColor(hex: item.color)
        }

        setupElements()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func actionButtonPressed() {
        let newView = BalanceEnterAlertView(item: item)
        DispatchQueue.main.async {
            self.transform(to: newView)
        }
    }
}

// MARK: - Setup View
extension BalanceStartAlertView {
    func setupElements() {
        //imageView.backgroundColor = #colorLiteral(red: 0.8431372549, green: 0.8470588235, blue: 0.8549019608, alpha: 1)
        imageView.image = #imageLiteral(resourceName: "pocket")
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 8


        specialtyLabel.text = "\(userName),\n Баланс вашего счёта составляет"
        specialtyLabel.numberOfLines = 0
        specialtyLabel.textAlignment = .center
        specialtyLabel.textColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        specialtyLabel.font = UIFont.init(name: "Helvetica", size: 20)

        balancedLabel.textColor = UIColor(#colorLiteral(red: 0.2549019608, green: 0.03921568627, blue: 0.9137254902, alpha: 1))
        balancedLabel.font = UIFont.init(name: "Helvetica", size: 30)
        balancedLabel.textAlignment = .center

        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)

    }
}


// MARK: - Setup Constraints
extension BalanceStartAlertView {
    func setupConstraints() {

        imageView.translatesAutoresizingMaskIntoConstraints = false
        specialtyLabel.translatesAutoresizingMaskIntoConstraints = false
        balancedLabel.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false

        addSubview(imageView)
        addSubview(specialtyLabel)
        addSubview(balancedLabel)
        addSubview(actionButton)

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
            balancedLabel.topAnchor.constraint(equalTo: specialtyLabel.bottomAnchor, constant: 12),
            balancedLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            balancedLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
        ])

        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: balancedLabel.bottomAnchor, constant: 17),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])


        bottomAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 34).isActive = true
    }
}

