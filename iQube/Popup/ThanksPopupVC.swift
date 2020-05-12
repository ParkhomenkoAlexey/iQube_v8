//
//  ThanksPopupVC.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 8/1/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

final class ThanksPopupVC: BasePopupVC {
	
	@IBOutlet weak private var textLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		textLabel.text = "\(UserManager.shared.user.name)\nСпасибо за обращение!"
		
	}
	
}
