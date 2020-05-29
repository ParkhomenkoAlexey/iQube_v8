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
    
    let item: ItemModel
    
    init(item: ItemModel) {
        self.item = item
        super.init(frame: UIScreen.main.bounds)

        if let url = URL(string: item.imageURL ?? "") {
            self.imageView.kf.setImage(with: url)
        }
        self.titleLabel.text = item.name
        self.descriptionLabel.text = item.text
        self.priceLabel.text = "\(Int(item.price ?? 0)) руб."
        setupElements()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func actionButtonPressed() {
        
        let newView = NameBuyPaymentAlertView(item: item)
        DispatchQueue.main.async {
            self.transform(to: newView)
        }
        
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
        
        priceLabel.textAlignment = .center

        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)

        priceLabel.textColor = UIColor(#colorLiteral(red: 0.2549019608, green: 0.03921568627, blue: 0.9137254902, alpha: 1))
        priceLabel.font = UIFont.init(name: "Helvetica", size: 30)
        priceLabel.textAlignment = .center


    }
}

// MARK: - Setup Constraints
extension NameBuyAlertView {
    func setupConstraints() {

        actionButton.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let labelsStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel], axis: .vertical, spacing: 10)
        let topStackView = UIStackView(arrangedSubviews: [imageView, labelsStackView], axis: .horizontal, spacing: 20)
        topStackView.alignment = .top
        topStackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(topStackView)
        addSubview(actionButton)
        addSubview(priceLabel)

        
        labelsStackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        imageView.widthAnchor.constraint(equalToConstant: 95).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 95).isActive = true
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: topAnchor, constant: 34),
            topStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            topStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            
        ])


        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 39),
            priceLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
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


