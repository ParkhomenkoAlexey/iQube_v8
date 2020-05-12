//
//  ARKitViewController+PopoverButton.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 8/8/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

extension ARKitVC {
	
	//MARK: - Plus Button
	func preparePlusButton() {
		DispatchQueue.main.async {
			let image = UIImage(from: .fontAwesome, code: "plus", size: CGSize(width: 30, height: 30)).withRenderingMode(.alwaysTemplate)
			self.plusButton.setImage(image, for: .normal)
			self.plusButton.tintColor = .white
			self.plusButton.backgroundColor = .blueColor
			self.plusButton.layer.cornerRadius = 10
			self.plusButton.addTarget(self, action: #selector(self.plusButtonAction(_:)), for: .touchUpInside)
			self.view.addSubview(self.plusButton)
			
			self.plusButton.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint(item: self.plusButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottomMargin, multiplier: 1, constant: -30).isActive = true
			NSLayoutConstraint(item: self.plusButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
			NSLayoutConstraint(item: self.plusButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 85).isActive = true
			NSLayoutConstraint(item: self.plusButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 85).isActive = true
		}
	}
	
	@objc private func plusButtonAction(_ sender: UIButton) {
		let image = UIImage(from: .fontAwesome, code: "times", size: CGSize(width: 30, height: 30)).withRenderingMode(.alwaysTemplate)
		plusButton.setImage(image, for: .normal)
		openPopoverView(sender)
	}
	
	func removePlusButtonFromSuperView() {
		DispatchQueue.main.async {
			self.popoverContentController?.dismiss(animated: false, completion: nil)
			self.popoverContentController = nil
			self.plusButton.removeFromSuperview()
		}
	}
	
	private func openPopoverView(_ sender: UIButton) {
		popoverContentController = PopoverTableView()
		popoverContentController?.modalPresentationStyle = .popover
		popoverContentController?.preferredContentSize = CGSize(width: 230, height: 150)
		popoverContentController?.feedbackItems = currentFeedbackItems
		if let popoverPresentationController = popoverContentController?.popoverPresentationController {
			popoverPresentationController.permittedArrowDirections = .down
			popoverPresentationController.sourceView = sender
			popoverPresentationController.sourceRect = CGRect(x: sender.frame.width/2, y: 0, width: 0, height: 0)
			popoverPresentationController.backgroundColor = .lightBlack
			if let vc = popoverContentController {
				present(vc, animated: true, completion: nil)
			}
		}
		
		popoverContentController?.closeView = { [weak self] in
			let image = UIImage(from: .fontAwesome, code: "plus", size: CGSize(width: 30, height: 30)).withRenderingMode(.alwaysTemplate)
			self?.plusButton.setImage(image, for: .normal)
		}
	}
	
}
