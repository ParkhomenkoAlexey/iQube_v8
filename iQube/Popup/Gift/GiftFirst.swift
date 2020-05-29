//
//  PresentFirst.swift
//  iQube
//
//  Created by Алексей Пархоменко on 27.05.2020.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
import SwiftEntryKit

struct GiftModel {
    var userName: String
    var giftName: String
}

class PresentStartAlert: UIView {

    private let imageView = UIImageView()
    private let specialtyLabel = UILabel()
    private let actionButton = AlertButton(title: "Получить", direction: .right, size: .large, type: .purple)
    let item: ItemModel
    
    init(item: ItemModel) {
        self.item = item
        super.init(frame: UIScreen.main.bounds)

        setupElements()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func actionButtonPressed() {
        let newView = PresentFinishAlert(item: item)
        DispatchQueue.main.async {
            self.transform(to: newView)
        }
    }
}

// MARK: - Setup View
extension PresentStartAlert {
    func setupElements() {
        
        imageView.image = UIImage(named: "present")
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 8
        
        let index = item.text.firstIndex(of: ",")
        let name = item.text.prefix(upTo: index!)
        let other = item.text.suffix(from: item.text.firstIndex(of: "\n")!).trimmingCharacters(in: .whitespacesAndNewlines)

        let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Helvetica-Bold", size: 18)]
        let attrs2 = [NSAttributedString.Key.font : UIFont(name: "Helvetica", size: 18)]
        let attributedString1 = NSMutableAttributedString(string:"\(name),\n", attributes:attrs1 as [NSAttributedString.Key : Any])
        let attributedString2 = NSMutableAttributedString(string:other, attributes:attrs2 as [NSAttributedString.Key : Any])

        attributedString1.append(attributedString2)
        specialtyLabel.attributedText = attributedString1
        specialtyLabel.numberOfLines = 0
        specialtyLabel.textAlignment = .center
//        specialtyLabel.textColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        specialtyLabel.font = UIFont.init(name: "Helvetica", size: 20)

        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)

    }
}


// MARK: - Setup Constraints
extension PresentStartAlert {
    func setupConstraints() {

        imageView.translatesAutoresizingMaskIntoConstraints = false
        specialtyLabel.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false

        addSubview(imageView)
        addSubview(specialtyLabel)
        addSubview(actionButton)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 44),
            imageView.heightAnchor.constraint(equalToConstant: 83),
            imageView.widthAnchor.constraint(equalToConstant: 88),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 130),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -130),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            specialtyLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 34),
            specialtyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            specialtyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),

        ])

        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: specialtyLabel.bottomAnchor, constant: 34),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])


        bottomAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 34).isActive = true
    }
}

