//
//  UIView+Anchor.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 5/3/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit

extension UIView {
    
    func anchor(centerY: NSLayoutYAxisAnchor? = nil, centerX: NSLayoutXAxisAnchor? = nil,
        top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil,
        widthAnchor: NSLayoutDimension? = nil, heightAnchor: NSLayoutDimension? = nil,
        paddingTop: CGFloat = 0, paddingBottom: CGFloat = 0,
        paddingLeft: CGFloat = 0, paddingRight: CGFloat = 0,
        width: CGFloat = 0, height: CGFloat = 0, multiplier: CGFloat = 1) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let widthA = widthAnchor {
            self.widthAnchor.constraint(equalTo: widthA, multiplier: multiplier, constant: -(paddingLeft + paddingRight)).isActive = true
        }
        
        if let heightA = heightAnchor {
            self.heightAnchor.constraint(equalTo: heightA, multiplier: multiplier, constant: -(paddingTop + paddingBottom)).isActive = true
        }
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let bot = bottom {
            self.bottomAnchor.constraint(equalTo: bot, constant: -paddingBottom).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if height != 0 {
            let roundedHeight = height.rounded()
            self.heightAnchor.constraint(equalToConstant: roundedHeight).isActive = true
        }
        
        if width != 0 {
            let roundedWidth = width.rounded()
            self.widthAnchor.constraint(equalToConstant: roundedWidth).isActive = true
        }
    }
    
    func anchor(centerY: NSLayoutYAxisAnchor? = nil, centerX: NSLayoutXAxisAnchor? = nil,
        top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil,
        widthAnchor: NSLayoutDimension? = nil, heightAnchor: NSLayoutDimension? = nil,
        insets: UIEdgeInsets = .zero, size: CGSize = .zero, multiplier: CGFloat = 1) {
        anchor(
            centerY: centerY, centerX: centerX,
            top: top, bottom: bottom, left: left, right: right,
            widthAnchor: widthAnchor, heightAnchor: heightAnchor,
            paddingTop: insets.top, paddingBottom: insets.bottom,
            paddingLeft: insets.left, paddingRight: insets.right,
            width: size.width, height: size.height, multiplier: multiplier
        )
    }
}
