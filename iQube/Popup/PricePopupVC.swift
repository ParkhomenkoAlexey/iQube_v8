//
//  ThreeViewController.swift
//  ARKitDemoProject
//
//  Created by Vlad Lavrenkov on 4/19/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import SwiftyJSON

final class PricePopupVC: BasePopupVC {
	
	@IBOutlet weak private var titleText: UILabel!
	@IBOutlet weak private var textLabel: UILabel!
	@IBOutlet weak private var priceLabel: UILabel!
	@IBOutlet weak private var myButton: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupVC()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		closeButton.isHidden = true
	}
	
	func setupVC() {
		guard let item = itemModel else {
			return
		}
		titleText.text = ""
		textLabel.text = item.text
		if let price = item.price {
			priceLabel.text = "\(price) р"
		}
        if let buttonText = item.buttonText {
            myButton.setTitle(buttonText, for: .normal)
        }
        
        if !item.color.isEmpty {
            myButton.tintColor = UIColor(hex: item.color)
        }
	}
}
