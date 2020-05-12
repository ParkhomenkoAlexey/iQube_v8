//
//  SignUpPhoneViewController.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 3/1/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit

class SignUpPhoneViewController: BaseViewController {
    
    // MARK: Properties
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var continueButton: UIButton!
    @IBOutlet private weak var profileIcon: UIImageView!
    @IBOutlet private weak var progressImage: UIImageView!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func updateKeyboardHeight(_ height: CGFloat) {
        super.updateKeyboardHeight(height)
        scrollView.contentInset.bottom = height
    }
    
    override func sendButton() {
        super.sendButton()
        guard let phone = phoneTextField.text, !phone.isEmpty else { return }
        UserManager.shared.user.phone = phone
        networkLayer.requestAuth { (success, userID) in
            if success, let id = userID {
                UserManager.shared.user.id = id
                self.performSegue(withIdentifier: .SMSCodeSegue, sender: self.applicationModel)
            }
        }
    }
}

private extension SignUpPhoneViewController {
    
    func setupView() {
        guard let model = applicationModel else { return }
        let color = UIColor(hex: model.colorButton)
        continueButton.tintColor = color
        profileIcon.tintColor = color
        progressImage.tintColor = color
    }
}
