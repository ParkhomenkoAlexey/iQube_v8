//
//  BasePopupVC.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 7/29/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class BasePopupVC: UIViewController {

	var apiManager = ApiManager()
	var itemModel: ItemModel?
    
    weak var arkitView: ARKitVC?
	
	@IBOutlet weak var closeButton: UIButton!
	@IBOutlet weak var bgView: UIView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		NotificationCenter.default.addObserver(self, selector: #selector(showCloseButton), name: .showCloseButton, object: nil)
		
		bgView.curveCorners()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		closeButton.tintColor = .grayColor
        bgView.layer.cornerRadius = 15
        bgView.clipsToBounds = true
	}
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arkitView?.isCanShowPopup = true
    }
	
	deinit {
		NotificationCenter.default.removeObserver(self, name: .showCloseButton, object: nil)
	}
	
	private func prepereBlurEffect() {
		let blurEffect = UIBlurEffect(style: .dark)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = self.view.frame
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		view.addSubview(blurEffectView)
	}
	
	@objc func showCloseButton() {
		closeButton.isHidden = false
	}
	
	@IBAction func pressOK(_ sender: UIButton) {
		if let markerID = itemModel?.id {
			apiManager.requestWebHook(userID: UserManager.shared.user.id, markerID: markerID, buttonID: 0)
		}
	
		if let url = itemModel?.buttonURL {
			url.openURL()
        } else {
            dismiss(animated: true, completion: nil)
        }
	}
	
	@IBAction func pressClose(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
	
}
