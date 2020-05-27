//
//  OrderLinkAlertView.swift
//  iQube
//
//  Created by Алексей Пархоменко on 27.05.2020.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
import SwiftEntryKit

class OrderLinkAlertView: UIView {

    private let imageView = UIImageView()
    private let fullNameLabel = UILabel()
    private let specialtyLabel = UILabel()

    init() {
        super.init(frame: UIScreen.main.bounds)

        setupElements()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup View
extension OrderLinkAlertView {
    func setupElements() {
      
        imageView.image = #imageLiteral(resourceName: "successful_icon")
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 8

        fullNameLabel.textAlignment = .center
        fullNameLabel.numberOfLines = 2
        fullNameLabel.textColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        fullNameLabel.font = UIFont.init(name: "Helvetica", size: 24)
        fullNameLabel.text = "Вам отправлена ссылка на оплату"


        specialtyLabel.text = "Менеджер свяжется с Вами сразу после заитчсления средств"
        specialtyLabel.numberOfLines = 0
        specialtyLabel.textAlignment = .center
        specialtyLabel.textColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        specialtyLabel.font = UIFont.init(name: "Helvetica", size: 15)



    }
}


// MARK: - Setup Constraints
extension OrderLinkAlertView {
    func setupConstraints() {

        imageView.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        specialtyLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(imageView)
        addSubview(fullNameLabel)
        addSubview(specialtyLabel)

        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 83),
            imageView.widthAnchor.constraint(equalToConstant: 83),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 53),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            fullNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 34),
            fullNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            fullNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -60),

        ])

        NSLayoutConstraint.activate([
            specialtyLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 27.1),
            specialtyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 36),
            specialtyLabel.rightAnchor.constraint(equalTo: rightAnchor, constant:  -36)
        ])

        bottomAnchor.constraint(equalTo: specialtyLabel.bottomAnchor, constant: 54).isActive = true
    }
}

