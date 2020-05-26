//
//  ButtonsViewController.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 5/3/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit

final class ButtonsViewController: UIViewController {

    // MARK: UI
    @IBOutlet private weak var buttonStackView: UIStackView?
    @IBOutlet private weak var navigationView: UIView?
    
    // MARK: Properties
    var model: ImageModel?
    var apiManager: ApiManager?
    
    weak var arkitView: ARKitVC?
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationView?.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        arkitView?.dotsImageView.isHidden = false
    }
}

// MARK: - extension + publoc

extension ButtonsViewController {
    
}

// MARK: - extension + private

private extension ButtonsViewController {
    
    func setupView() {
        guard let model = model else { return }
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .vertical
        let buttons = model.items.filter({ $0.type == .Button })
        buttons.forEach {
            let button = ButtonView(frame: .zero, button: $0)
            button.callback = { [weak self] (buttonId) in
                print("button Tapped")
                self?.handleButtonTap(buttonId: buttonId)
            }
            stackView.addArrangedSubview(button)
            let buttonHeight: CGFloat = 50
            button.anchor(height: buttonHeight)
            button.layer.cornerRadius = buttonHeight / 2
            button.clipsToBounds = true
        }
        
        view.addSubview(stackView)
        stackView.anchor(bottom: view.bottomAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingBottom: 40,
                         paddingLeft: 20,
                         paddingRight: 20)
        
        let descLabel = UILabel(frame: .zero)
        descLabel.numberOfLines = 0
        descLabel.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        descLabel.textColor = .white
        descLabel.text = ApplicationInfoModel.appDescription
        view.addSubview(descLabel)
        descLabel.anchor(bottom: stackView.topAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingBottom: 20,
                         paddingLeft: 20,
                         paddingRight: 20)
        
    }
    
    func handleButtonTap(buttonId id: Int) {
        guard let button = model?.items.filter({ $0.id == id && $0.type == .Button }).first else { return }
        apiManager?.requestWebHook(userID: UserManager.shared.user.id, markerID: button.id, buttonID: button.bgID)
        switch button.btn_type {
        case .call:
            callNumber(button.btn_type_value)
        case .url:
            openURL(button.btn_type_value)
        case .webhook:
            break
        case .request:
            break
        case .none:
            break
        }
    }
    
    func callNumber(_ number: String) {
        let numberString = number.replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "-", with: "")
        if let number = URL(string: "tel://\(numberString)") {
            UIApplication.shared.open(number, options: [:], completionHandler: nil)
        }
    }
    
    func openURL(_ url: String) {
        if let url = URL(string: url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func didTapBackButton() {
        arkitView?.isCanShowPopup = true
        self.dismiss(animated: true, completion: nil)
    }
}
