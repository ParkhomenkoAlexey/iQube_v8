//
//  UIView + Extension.swift
//  PopUpWindows
//
//  Created by Алексей Пархоменко on 27.05.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit
import SwiftEntryKit

extension UIView {
    
    func transform(to view: UIView) {
        view.autosize(maxWidth: frame.width)
        
        let previousHeight = set(.height, of: frame.height, priority: .must)
        let nextHeight = set(.height, of: view.frame.height, priority: .defaultLow)
    
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.beginFromCurrentState, .layoutSubviews], animations: {

            previousHeight.priority = .defaultLow
            nextHeight.priority = .must

            self.alpha = 0

            SwiftEntryKit.layoutIfNeeded()

        }, completion: { (finished) in
            self.subviews.forEach({ $0.removeFromSuperview() })
            
            self.removeConstraints([previousHeight, nextHeight])

            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseOut], animations: {
                self.alpha = 1
                view.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(view)
                NSLayoutConstraint.activate([
                    view.topAnchor.constraint(equalTo: self.topAnchor),
                    view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                    view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                    view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
                ])

            }, completion: nil)
        })
    }

    func autosize(maxWidth: CGFloat) {

        translatesAutoresizingMaskIntoConstraints = false

        let dummyContainerView = UIView(frame: CGRect(x: 0, y: 0, width: maxWidth, height: 10000000))
        dummyContainerView.addSubview(self)
        dummyContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        dummyContainerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        dummyContainerView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true

        setNeedsLayout()
        layoutIfNeeded()

        removeFromSuperview()

        frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)

        translatesAutoresizingMaskIntoConstraints = true
    }
}
