//
//  FirstPopupViewController.swift
//  ARKitDemoProject
//
//  Created by Vlad Lavrenkov on 4/19/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

final class GiftPopupVC: BasePopupVC {
	
	@IBOutlet weak private var descText: UILabel!
	@IBOutlet weak private var myButton: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		descText.text = "Получите\nВаш подарок"
		
		setupVC()
		closeButton.isHidden = true
    }
	
	func setupVC() {
		guard let item = itemModel else { return }
        
        let textAttrs = [NSAttributedString.Key.font : descText.font]
        
        let lastTextAttrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: descText.font.pointSize, weight: .bold)]
        let lastTextString = NSMutableAttributedString(string: "\n" + item.name, attributes: lastTextAttrs)
        
        let textString = NSMutableAttributedString(string: item.text, attributes: textAttrs)
        textString.append(lastTextString)
        descText.attributedText = textString
        
        if !item.color.isEmpty {
            myButton.tintColor = UIColor(hex: item.color)
        }
        
	}
	
}
