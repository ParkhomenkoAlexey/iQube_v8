//
//  SignUpNameViewController.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 3/1/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
import Kingfisher
import Hex

class SignUpNameViewController: BaseViewController {
    
    // MARK: Properties
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var continueButton: UIButton!
    @IBOutlet private weak var profileIcon: UIImageView!
    @IBOutlet private weak var progressImage: UIImageView!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func updateKeyboardHeight(_ height: CGFloat) {
        scrollView.contentInset.bottom = height
    }
    
    override func sendButton() {
        super.sendButton()
        guard let name = nameTextField.text, !name.isEmpty else { return }
        UserManager.shared.user.name = name
        performSegue(withIdentifier: .SignUpPhoneSegue, sender: applicationModel)
    }
    
}

extension SignUpNameViewController {
    
    func setupView() {
        guard let model = applicationModel else { return }
        let color = UIColor(hex: model.colorButton)
        continueButton.tintColor = color
        profileIcon.tintColor = color
        progressImage.tintColor = color
    }
}
