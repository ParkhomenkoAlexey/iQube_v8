//
//  QubeTextField.swift
//  iQube
//
//  Created by Vlad on 9/14/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class QubeTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        self.textColor = .white
        setupSeparator()
    }
    
    private func setupSeparator() {
        self.borderStyle = .none
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
}
