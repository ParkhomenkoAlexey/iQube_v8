//
//  BuySecond.swift
//  iQube
//
//  Created by Алексей Пархоменко on 27.05.2020.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
import SwiftEntryKit

class NameBuyAlertView: UIView {

    let imageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let priceLabel = UILabel()
    let actionButton = AlertButton(title: "Купить", direction: .right, size: .large, type: .purple)
    
    let model: PriceModel
    
    init(model: PriceModel) {
        self.model = model
        super.init(frame: UIScreen.main.bounds)

        self.imageView.image = model.productImage
        self.titleLabel.text = model.productName
        self.descriptionLabel.text = model.description
        self.priceLabel.text = "\(model.price) руб."
        setupElements()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func actionButtonPressed() {
        
        let newView = NameBuyPaymentAlertView(model: model)
        transform(to: newView)
        
    }
}



// MARK: - Setup View
extension NameBuyAlertView {
    func setupElements() {
        imageView.backgroundColor = #colorLiteral(red: 0.8431372549, green: 0.8470588235, blue: 0.8549019608, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8

        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.init(name: "Helvetica-Bold", size: 20)
        titleLabel.textColor = #colorLiteral(red: 0.05098039216, green: 0.05490196078, blue: 0.06274509804, alpha: 1)

        descriptionLabel.font = UIFont.init(name: "Helvetica", size: 16)
        descriptionLabel.textColor = #colorLiteral(red: 0.05098039216, green: 0.05490196078, blue: 0.06274509804, alpha: 0.4960764657)
        descriptionLabel.numberOfLines = 0

        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)

        priceLabel.textColor = UIColor(#colorLiteral(red: 0.2549019608, green: 0.03921568627, blue: 0.9137254902, alpha: 1))
        priceLabel.font = UIFont.init(name: "Helvetica", size: 30)
        priceLabel.textAlignment = .center


    }
}

// MARK: - Setup Constraints
extension NameBuyAlertView {
    func setupConstraints() {

        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(actionButton)
        addSubview(priceLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 34),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            imageView.widthAnchor.constraint(equalToConstant: 95),
            imageView.heightAnchor.constraint(equalToConstant: 95)
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 34),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10 ),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -37)
        ])

        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 39),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100)
        ])

        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 35),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        bottomAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 34).isActive = true
    }
}


