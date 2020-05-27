//
//  EmployeeThird.swift
//  iQube
//
//  Created by Алексей Пархоменко on 26.05.2020.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
import SwiftEntryKit


class FullEmployeeAlertView: UIView {
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let positionLabel = UILabel()
    let descriptionLabel = UILabel()
    let actionButton = AlertButton(title: "Выбрать дату визита", direction: .left, size: .large, type: .clear)
    
    var apiManager = ApiManager()
    let itemModel: ItemModel
    
    weak var arkitView: ARKitVC?
    
    init(item: ItemModel) {
        self.itemModel = item
        super.init(frame: UIScreen.main.bounds)
        setupVC()
        setupElements()
        setupConstraints()
    }
    
    func setupVC() {
        guard let specialist = itemModel.specialist else { return }
        if let urlString = specialist.image_url, let url = URL(string: urlString) {
            imageView.kf.setImage(with: url)
        }
        titleLabel.text = specialist.fullname
        positionLabel.text = specialist.specialty
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func actionButtonPressed() {
        let newView = EmployeeFinishAlertView(dateRecorded: "23.03.2020", specialistName: "Филимонов Илья")
        DispatchQueue.main.async {
            self.transform(to: newView)
        }
    }
}

// MARK: - Setup View
extension FullEmployeeAlertView {
    func setupElements() {
        imageView.backgroundColor = #colorLiteral(red: 0.8431372549, green: 0.8470588235, blue: 0.8549019608, alpha: 1)
        imageView.layer.cornerRadius = 8
        
        descriptionLabel.text = "The state of Utah in the United States is home to lots of beautiful Park The state of Utah in the United States is home to lots of beautiful Parks The state of Utah in the United States is home to lots of  home to lots of beautiful Park The state of Utah in the United States is home to lots of beautiful Parks The state of Utah in the United States is home to lots of "
        
        titleLabel.textAlignment = .center
        
        titleLabel.numberOfLines = 2
        positionLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 5
        
        titleLabel.font = UIFont.init(name: "Helvetica-Bold", size: 20)
        titleLabel.textColor = #colorLiteral(red: 0.05098039216, green: 0.05490196078, blue: 0.06274509804, alpha: 1)
        
        positionLabel.font = UIFont.init(name: "Helvetica-Light", size: 15)
        positionLabel.textColor = #colorLiteral(red: 0.05098039216, green: 0.05490196078, blue: 0.06274509804, alpha: 1)
        
        positionLabel.font = UIFont.init(name: "Helvetica", size: 16)
        positionLabel.textColor = #colorLiteral(red: 0.05098039216, green: 0.05490196078, blue: 0.06274509804, alpha: 1)
        
        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
    }
}

// MARK: - Setup Constraints
extension FullEmployeeAlertView {
    func setupConstraints() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(positionLabel)
        addSubview(descriptionLabel)
        addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 26),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 96),
            imageView.heightAnchor.constraint(equalToConstant: 96)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 18),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            positionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            positionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            positionLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 25),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        bottomAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 34).isActive = true
    }
}



