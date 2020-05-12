//
//  PopoverItemModel.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 8/12/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import SwiftyJSON

enum FeedbackItemType: String {
	case call = "call"
	case buy = "buy"
}

class FeedbackItemModel {
	
	var id: Int?
	var type: FeedbackItemType?
	var phone: String?
	var link: String?
	
	init(json: JSON) {
		self.id = json["id"].int
		self.type = FeedbackItemType(rawValue: json["type"].stringValue)
		self.phone = json["phone"].stringValue
		self.link = json["link"].string
	}
	
}
