//
//  HUDView.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 7/31/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation

import UIKit

class HUDView: UIView {
	
	static public let shared = HUDView()
	
	private let progressView = UIView(frame: CGRect())
	private var isShowingToast = false
	private var isShowingProgress = false
	
	
	func showProgress(controller: UIViewController) {
		if isShowingProgress {
			return
		}
		self.isShowingProgress = true
		progressView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
		progressView.alpha = 0.0
		progressView.layer.cornerRadius = 10;
		progressView.clipsToBounds  =  true
		
		let progress = UIActivityIndicatorView()
		progress.startAnimating()
		
		progressView.addSubview(progress)
		controller.view.addSubview(progressView)
		
		progress.translatesAutoresizingMaskIntoConstraints = false
		progressView.translatesAutoresizingMaskIntoConstraints = false
		
		//constaint for text
		NSLayoutConstraint(item: progress, attribute: .leading, relatedBy: .equal, toItem: progressView, attribute: .leading, multiplier: 1, constant: 15).isActive = true
		NSLayoutConstraint(item: progress, attribute: .trailing, relatedBy: .equal, toItem: progressView, attribute: .trailing, multiplier: 1, constant: -15).isActive = true
		NSLayoutConstraint(item: progress, attribute: .bottom, relatedBy: .equal, toItem: progressView, attribute: .bottom, multiplier: 1, constant: -15).isActive = true
		NSLayoutConstraint(item: progress, attribute: .top, relatedBy: .equal, toItem: progressView, attribute: .top, multiplier: 1, constant: 15).isActive = true
		
		//constaint for view
		NSLayoutConstraint(item: progressView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 100).isActive = true
		NSLayoutConstraint(item: progressView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 100).isActive = true
		NSLayoutConstraint(item: progressView, attribute: .centerY, relatedBy: .equal, toItem: controller.view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
		NSLayoutConstraint(item: progressView, attribute: .centerX, relatedBy: .equal, toItem: controller.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
		
		
		UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
			self.progressView.alpha = 1.0
		})
	}
	
	func hideProgress() {
		DispatchQueue.main.async {
			UIView.animate(withDuration: 0.5, animations: {
				self.isShowingProgress = false
				_ = self.progressView.subviews.map({ $0.removeFromSuperview() })
				self.progressView.removeFromSuperview()
			})
		}
	}
}
