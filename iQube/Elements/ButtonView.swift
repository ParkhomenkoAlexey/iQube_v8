//
//  ClickableView.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 7/15/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import Hex

class ButtonView: UIButton{
	
	var callback:((_ buttonID: Int)->())?
	private var button: ItemModel?
	
	init(frame: CGRect, button: ItemModel) {
		super.init(frame: frame)
		self.button = button
        
		self.addTarget(self, action:  #selector(objectTapped(_:)), for: .touchUpInside)
		
		self.setTitle(button.text, for: .normal)
        
        let buttonTextColor = UIColor(hex: button.color)
        self.setTitleColor(buttonTextColor, for: .normal)
        
		self.titleLabel?.adjustsFontSizeToFitWidth = true
		
		self.titleLabel?.font = UIFont(name: button.font, size: CGFloat(button.fontSize))
		
		self.layer.borderColor = UIColor(hex: button.border_color).cgColor
		self.layer.borderWidth = CGFloat(button.border_width)
		
		self.backgroundColor = UIColor(hex: button.background)
		
		self.tag = button.id
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc func objectTapped(_ sender: UIButton){
        if let cl = callback, let id = button?.id {
			cl(id)
		}
	}
	
	deinit {
		debugPrint("\(self) deinit")
	}
	
}
