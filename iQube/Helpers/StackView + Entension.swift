//
//  StackView + Entension.swift
//  iQube
//
//  Created by Алексей Пархоменко on 26.05.2020.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
    }
    
}
