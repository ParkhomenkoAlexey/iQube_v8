//
//  Congratulate.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 3/7/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
import Hex

class CongratulateViewController: BaseViewController {
    
    // MARK: IBOutlets
    @IBOutlet private weak var continueButton: UIButton!
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var progressImage: UIImageView!
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func sendButton() {
        super.sendButton()
        performSegue(withIdentifier: .WorkspaceSegue, sender: applicationModel)
    }
}

private extension CongratulateViewController {
    
    func setupView() {
        guard let model = applicationModel else { return }
        let color = UIColor(hex: model.colorButton)
        continueButton.tintColor = color
        icon.tintColor = color
        progressImage.tintColor = color
    }
}
