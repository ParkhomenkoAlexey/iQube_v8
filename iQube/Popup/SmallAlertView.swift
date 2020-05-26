//
//  SmallAlertView.swift
//  iQube
//
//  Created by Алексей Пархоменко on 26.05.2020.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import SwiftEntryKit

class SmallAlertView: UIView {
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let positionLabel = UILabel()
    let actionButton = AlertButton(direction: .right, size: .small, type: .purple)
    
    init(image: UIImage, name: String, position: String) {
        super.init(frame: UIScreen.main.bounds)
//        imageView.image = image
        imageView.backgroundColor = #colorLiteral(red: 0.8431372549, green: 0.8470588235, blue: 0.8549019608, alpha: 1)
        titleLabel.text = name
        positionLabel.text = position
        setupElements()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func actionButtonPressed() {
        
        SwiftEntryKit.transform(to: FullEmployeeAlertView(image: #imageLiteral(resourceName: "ic_done_all_dark_48pt"), name: "Александровсвкий\nСтанислав", position: "Сотрудник"))

    }
}

// MARK: - Setup View
extension SmallAlertView {
    func setupElements() {
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 8
        
        titleLabel.numberOfLines = 0
        positionLabel.numberOfLines = 0
        
        titleLabel.font = UIFont.init(name: "Helvetica", size: 15)
        titleLabel.textColor = #colorLiteral(red: 0.05098039216, green: 0.05490196078, blue: 0.06274509804, alpha: 1)
        
        positionLabel.font = UIFont.init(name: "Helvetica", size: 15)
        positionLabel.textColor = #colorLiteral(red: 0.05098039216, green: 0.05490196078, blue: 0.06274509804, alpha: 0.3049640487)
        
        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
    }
}

// MARK: - Setup Constraints
extension SmallAlertView {
    func setupConstraints() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(positionLabel)
        addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            positionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            positionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            positionLabel.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            actionButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 2), // потому что тени
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -19),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            actionButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 21).isActive = true
    }
}

