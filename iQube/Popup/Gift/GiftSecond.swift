//
//  PresentSecond.swift
//  iQube
//
//  Created by Алексей Пархоменко on 27.05.2020.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
import SwiftEntryKit

class PresentFinishAlert: UIView {

    private let imageView = UIImageView()
    private let specialtyLabel = UILabel()
    private var presentNameLabel = UILabel()
    let item: ItemModel

    init(item: ItemModel) {
        self.item = item
        super.init(frame: UIScreen.main.bounds)
        self.presentNameLabel.text = item.name
        
        setupElements()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Setup View
extension PresentFinishAlert {
    func setupElements() {
        
        imageView.image = UIImage(named: "present")
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 8

        presentNameLabel.font = UIFont.init(name: "Helvetica-Bold", size: 20)
        presentNameLabel.textColor = #colorLiteral(red: 0.05098039216, green: 0.05490196078, blue: 0.06274509804, alpha: 1)
        presentNameLabel.textAlignment = .center


        specialtyLabel.text = "Забрать свой подарок Вы можете Для Вас мы подготовили персональтный подарок"
        specialtyLabel.font = UIFont.init(name: "Helvetica", size: 18)
        specialtyLabel.numberOfLines = 0
        specialtyLabel.textAlignment = .center

    }
}


// MARK: - Setup Constraints
extension PresentFinishAlert {
    func setupConstraints() {

        imageView.translatesAutoresizingMaskIntoConstraints = false
        specialtyLabel.translatesAutoresizingMaskIntoConstraints = false
        presentNameLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(imageView)
        addSubview(specialtyLabel)
        addSubview(presentNameLabel)


        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 44),
            imageView.heightAnchor.constraint(equalToConstant: 83),
            imageView.widthAnchor.constraint(equalToConstant: 88),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 130),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -130),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            presentNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 43),
            presentNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            presentNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
        ])

        NSLayoutConstraint.activate([
            specialtyLabel.topAnchor.constraint(equalTo: presentNameLabel.bottomAnchor, constant: 12),
            specialtyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            specialtyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),

        ])



        bottomAnchor.constraint(equalTo: specialtyLabel.bottomAnchor, constant: 65).isActive = true
    }
}

