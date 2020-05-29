//
//  EmployeeSecond.swift
//  iQube
//
//  Created by Алексей Пархоменко on 29.05.2020.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
import SwiftEntryKit

class DateEmployeeAlertView: UIView {

    let imageView = UIImageView()
    let titleLabel = UILabel()
    let positionLabel = UILabel()
    let actionDetailButton = AlertButton(direction: .right, size: .small, type: .purple)
    let actionButton = AlertButton(title: "Записаться", direction: .right, size: .large, type: .purple)
    var dates: [Date] = []
    let chooseDateLabel = UILabel()
    var mounth: [String] = []
    var mounthSegmentControl: CustomSegmentedControl?
    
    var apiManager = ApiManager()
    
    let itemModel: ItemModel

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
        self.dates = [Date]()
        titleLabel.text = specialist.fullname
        positionLabel.text = specialist.specialty
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func actionButtonPressed() {
        let newView = FullEmployeeAlertView(item: self.itemModel)
        DispatchQueue.main.async {
            self.transform(to: newView)
        }
    }

    @objc func actionButtonFinigh() {
        
        // не хватает обработчика ошибок
        print("item.id: \(itemModel.id)")
        apiManager.requestWebHook(userID: UserManager.shared.user.id, markerID: itemModel.id, buttonID: 0)
        
        if let url = itemModel.buttonURL {
            url.openURL()
        } else {
            print("no openUrl")
        }
        
        let newView = EmployeeFinishAlertView(dateRecorded: "23.03.2020", specialistName: "Филимонов Илья")
        DispatchQueue.main.async {
            self.transform(to: newView)
        }
    }
}

// MARK: - Setup View
extension DateEmployeeAlertView {
    func setupElements() {
        imageView.backgroundColor = #colorLiteral(red: 0.8431372549, green: 0.8470588235, blue: 0.8549019608, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8

        titleLabel.numberOfLines = 0
        positionLabel.numberOfLines = 0

        titleLabel.font = UIFont.init(name: "Helvetica-Bold", size: 20)
        titleLabel.textColor = #colorLiteral(red: 0.05098039216, green: 0.05490196078, blue: 0.06274509804, alpha: 1)

        positionLabel.font = UIFont.init(name: "Helvetica", size: 15)
        positionLabel.textColor = #colorLiteral(red: 0.05098039216, green: 0.05490196078, blue: 0.06274509804, alpha: 0.3049640487)

        actionDetailButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        actionButton.addTarget(self, action: #selector(actionButtonFinigh), for: .touchUpInside)

        chooseDateLabel.text = "Выберите дату для визита к специалисту"
        chooseDateLabel.textAlignment = .center
        chooseDateLabel.numberOfLines = 0
        chooseDateLabel.font = UIFont.init(name: "Helvetica", size: 16)

        fetchMonth()
    }

    private func fetchMonth() {

        let date = Date()
        let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: Date())
        guard let currentMounthString = nextMonth?.monthAsString() else { return }
        let nextMonthString = date.monthAsString() // Returns current month e.g. "May"
        mounth.append(nextMonthString)
        mounth.append(currentMounthString)
        mounthSegmentControl = CustomSegmentedControl(buttonTitle: mounth)
    }
}

// MARK: - Setup Constraints
extension DateEmployeeAlertView {
    func setupConstraints() {

        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        actionDetailButton.translatesAutoresizingMaskIntoConstraints = false
        mounthSegmentControl!.translatesAutoresizingMaskIntoConstraints = false
        chooseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false

        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(positionLabel)
        addSubview(actionDetailButton)
        addSubview(mounthSegmentControl!)
        addSubview(chooseDateLabel)
        addSubview(actionButton)


        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 26),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -19),
            imageView.heightAnchor.constraint(equalToConstant: 95),
            imageView.widthAnchor.constraint(equalToConstant: 95)

        ])

        NSLayoutConstraint.activate([
            actionDetailButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 25),
            actionDetailButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -19 - 47.5 / 2),

            actionDetailButton.heightAnchor.constraint(equalToConstant: 50),
            actionDetailButton.widthAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 16)

        ])

        NSLayoutConstraint.activate([
            positionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            positionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            positionLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 16)
        ])

        NSLayoutConstraint.activate([
            chooseDateLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 65),
            chooseDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 75),
            chooseDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -75),
        ])

        NSLayoutConstraint.activate([
            mounthSegmentControl!.topAnchor.constraint(equalTo: chooseDateLabel.bottomAnchor, constant: 3),
            mounthSegmentControl!.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            mounthSegmentControl!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            mounthSegmentControl!.heightAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: mounthSegmentControl!.bottomAnchor, constant: 35),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        bottomAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 34).isActive = true
    }
}


extension Date {
    func monthAsString() -> String {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("MMM")
        return df.string(from: self)
    }
}

