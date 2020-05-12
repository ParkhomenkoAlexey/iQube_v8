//
//  AppIDController.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 3/1/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
import KeychainSwift

class AppIDController: BaseViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var appIdTextField: UITextField!
    @IBOutlet private weak var startButton: UIButton!
    @IBOutlet private weak var errorLabel: UILabel!
    
    // MARK: overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func updateKeyboardHeight(_ height: CGFloat) {
        scrollView.contentInset.bottom = height
    }
}


// MARK: - private + extension

private extension AppIDController {
 
    func setupView() {
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        appIdTextField.delegate = self
    }
    
    @objc func didTapStartButton() {
        getApplicationInfo(appId: appIdTextField.text)
    }
    
    func getApplicationInfo(appId: String?) {
        guard let id = appId else { return }
        networkLayer.requestGetApplicationInfo(id: id) { [weak self] (success, appInfoModel) in
            guard success else { return }
            if let errorMessage = appInfoModel?.errorMessage {
                self?.mainBlock {
                    self?.errorLabel.text = errorMessage
                }
                return
            }
            KeychainSwift().set(id, forKey: Const.KeychainKeys.appID)
            if let token = UserManager.shared.user.token, !token.isEmpty {
                self?.performSegue(withIdentifier: .WorkspaceSegue, sender: appInfoModel)
            } else {
                self?.performSegue(withIdentifier: .ApplicationInfoSegue, sender: appInfoModel)
            }
        }
    }
    
}


extension AppIDController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        errorLabel.text = nil
        return true
    }
}
