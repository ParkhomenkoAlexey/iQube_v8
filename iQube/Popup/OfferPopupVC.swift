//
//  SecondViewController.swift
//  ARKitDemoProject
//
//  Created by Vlad Lavrenkov on 4/19/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

final class OfferPopupVC: BasePopupVC {
	
	@IBOutlet weak private var myButton: UIButton!
	@IBOutlet weak private var textLabel: UILabel!
	@IBOutlet weak private var nameLabel: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupVC()
		closeButton.isHidden = true
	}
	
	func setupVC() {
		guard let item = itemModel else { return }
		nameLabel.text = UserManager.shared.user.name
		textLabel.text = item.text
        print(#function + "item.text")
        
        if !item.color.isEmpty {
            myButton.tintColor = UIColor(hex: item.color)
        }
	}
}
