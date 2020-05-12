//
//  SMSCodeVC.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 7/25/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class SMSCodeViewController: BaseViewController {
	
    @IBOutlet private weak var scrollView: UIScrollView!
	@IBOutlet private weak var sendCode: UIButton!
    @IBOutlet private weak var txtOTP4: UITextField!
    @IBOutlet private weak var txtOTP3: UITextField!
    @IBOutlet private weak var txtOTP2: UITextField!
    @IBOutlet private weak var txtOTP1: UITextField!
    @IBOutlet private weak var continueButton: UIButton!
    @IBOutlet private weak var progressImage: UIImageView!
    @IBOutlet private weak var errorLabel: UILabel!
	
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
        guard let smsCode = getSMSCodeFromTextField(), !smsCode.isEmpty else { return }
		UserManager.shared.user.smsCode = smsCode
        networkLayer.requestConfirmCode(code: smsCode, userID: UserManager.shared.user.id) { [weak self] (success) in
            if success {
                UserManager.shared.user.smsCode = nil
                self?.performSegue(withIdentifier: .CongratulateSegue, sender: self?.applicationModel)
            } else {
                self?.showErrorAlert(title: "Ошибка", message: "Введён неверный код")
            }
        }
	}
}

extension SMSCodeViewController: UITextFieldDelegate {
	
    private func getSMSCodeFromTextField() -> String? {
        guard let t1 = txtOTP1.text, let t2 = txtOTP2.text, let t3 = txtOTP3.text, let t4 = txtOTP4.text else { return nil }
        let code = t1 + t2 + t3 + t4
        return code.count == 4 ? code : nil
    }
    
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.view.endEditing(true)
		return true
	}
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if ((textField.text?.count)! < 1 ) && (string.count > 0) {
            if textField == txtOTP1 {
                txtOTP2.becomeFirstResponder()
            }
            
            if textField == txtOTP2 {
                txtOTP3.becomeFirstResponder()
            }
            
            if textField == txtOTP3 {
                txtOTP4.becomeFirstResponder()
            }
            
            if textField == txtOTP4 {
                txtOTP4.resignFirstResponder()
            }
            
            textField.text = string
            return false
        } else if ((textField.text?.count)! >= 1) && (string.count == 0) {
            if textField == txtOTP2 {
                txtOTP1.becomeFirstResponder()
            }
            if textField == txtOTP3 {
                txtOTP2.becomeFirstResponder()
            }
            if textField == txtOTP4 {
                txtOTP3.becomeFirstResponder()
            }
            if textField == txtOTP1 {
                txtOTP1.resignFirstResponder()
            }
            
            textField.text = ""
            return false
        } else if (textField.text?.count)! >= 1 {
            textField.text = string
            return false
        }
        
        return true
    }
	
}


private extension SMSCodeViewController {
    
    func setupView() {
        
        if let model = applicationModel {
            let color = UIColor(hex: model.colorButton)
            continueButton.tintColor = color
            progressImage.tintColor = color
        }
        addBottomBorderTo(textField: txtOTP1)
        addBottomBorderTo(textField: txtOTP2)
        addBottomBorderTo(textField: txtOTP3)
        addBottomBorderTo(textField: txtOTP4)
        
        txtOTP1.delegate = self
        txtOTP2.delegate = self
        txtOTP3.delegate = self
        txtOTP4.delegate = self
    }
    
    func addBottomBorderTo(textField:UITextField) {
        let layer = CALayer()
        layer.backgroundColor = UIColor.white.cgColor
        layer.frame = CGRect(x: 0.0, y: textField.frame.size.height - 2.0, width: textField.frame.size.width, height: 2.0)
        textField.layer.addSublayer(layer)
    }
}
