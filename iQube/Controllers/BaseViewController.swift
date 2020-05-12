//
//  BaseVC.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 7/25/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

enum SegueIdentifier: String {
    case ApplicationInfoSegue
    case SignUpNameSegue
    case SignUpPhoneSegue
    case SMSCodeSegue
    case CongratulateSegue
    case WorkspaceSegue
    case AppIDSegue
}

class BaseViewController: UIViewController {
	
    let networkLayer = ApiManager()
    
    var applicationModel: ApplicationInfoModel?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
        setupNotifications()
        
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.view.endEditing(true)
	}
	
    func needOpenSMSVC(userID: Int) {
		DispatchQueue.main.async {
			let smsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SMSCodeVC") as! SMSCodeViewController
			self.present(smsVC, animated: false, completion: nil)
		}
	}
    
    func mainBlock(_ completion: EmptyCompletion) {
        DispatchQueue.main.async {
            completion?()
        }
    }
	
	
	@IBAction func sendButton() {}
    
    @IBAction func backButtom() {
        dismiss(animated: false, completion: nil)
    }
    
    func updateKeyboardHeight(_ height: CGFloat) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? [Any?],
            let segueName = sender.first,
            let info = sender.last
        else { return }
        switch segueName as? SegueIdentifier {
        case .ApplicationInfoSegue:
            prepareGreetingViewController(for: segue, info: info)
        case .SignUpNameSegue:
            prepareSignUpNameViewController(for: segue, info: info)
        case .SignUpPhoneSegue:
            prepareSignUpPhoneViewController(for: segue, info: info)
        case .SMSCodeSegue:
            prepareSMSCodeViewController(for: segue, info: info)
        case .CongratulateSegue:
            prepareCongratulateViewController(for: segue, info: info)
        case .WorkspaceSegue:
            prepareWorkspaceViewController(for: segue, info: info)
        default:
            break
        }
    }
    
    func performSegue(withIdentifier: SegueIdentifier, sender: Any?) {
        DispatchQueue.main.async {
            let customSender = [withIdentifier, sender]
            self.performSegue(withIdentifier: withIdentifier.rawValue, sender: customSender)
        }
    }
}

// MARK: - private + extension

private extension BaseViewController {
    
    func setupView() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardWillShow(_:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardWillHide(_:)), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    @objc func onKeyboardWillShow(_ notification: Notification) {
        if let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let rect = value.cgRectValue
            updateKeyboardHeight(rect.height)
        }
    }
    
    @objc func onKeyboardWillHide(_ notification: Notification) {
        updateKeyboardHeight(0)
    }
    
}

// MARK: - private + extension + prepare

private extension BaseViewController {
    
    func prepareGreetingViewController(for segue: UIStoryboardSegue, info: Any?) {
        guard let controller = segue.destination as? GreetingViewController, let model = info as? ApplicationInfoModel else { return }
        
        controller.applicationModel = model
    }
    
    func prepareSignUpNameViewController(for segue: UIStoryboardSegue, info: Any?) {
        guard let controller = segue.destination as? SignUpNameViewController, let model = info as? ApplicationInfoModel else { return }
        
        controller.applicationModel = model
    }
    
    func prepareSignUpPhoneViewController(for segue: UIStoryboardSegue, info: Any?) {
        guard let controller = segue.destination as? SignUpPhoneViewController, let model = info as? ApplicationInfoModel else { return }
        
        controller.applicationModel = model
    }
    
    func prepareSMSCodeViewController(for segue: UIStoryboardSegue, info: Any?) {
        guard let controller = segue.destination as? SMSCodeViewController, let model = info as? ApplicationInfoModel else { return }
        
        controller.applicationModel = model
    }
    
    func prepareCongratulateViewController(for segue: UIStoryboardSegue, info: Any?) {
        guard let controller = segue.destination as? CongratulateViewController, let model = info as? ApplicationInfoModel else { return }
        
        controller.applicationModel = model
    }
    
    func prepareWorkspaceViewController(for segue: UIStoryboardSegue, info: Any?) {
        guard let navigationController = segue.destination as? UINavigationController, let controller = navigationController.topViewController as? WorkspaceViewController,  let model = info as? ApplicationInfoModel else { return }
        
        controller.applicationModel = model
    }
}
