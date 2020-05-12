//
//  GreetingViewController.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 3/7/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
import Kingfisher
import Hex

final class GreetingViewController: BaseViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var logo: UIImageView!
    @IBOutlet private weak var applicationText: UILabel!
    @IBOutlet private weak var authButton: UIButton!
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func sendButton() {
        super.sendButton()
        performSegue(withIdentifier: .SignUpNameSegue, sender: applicationModel)
    }
}


extension GreetingViewController {
    
    func setupView() {
        guard let model = applicationModel else { return }
        logo.kf.setImage(with: model.logoURL)
        applicationText.text = model.descriptionApplication
        authButton.setTitle(model.textButton, for: .normal)
        authButton.tintColor = UIColor(hex: model.colorButton)
    }
}
