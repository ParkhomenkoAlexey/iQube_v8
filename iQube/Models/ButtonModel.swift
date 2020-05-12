//
//  ButtonModel.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 7/22/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import SwiftyJSON

class ButtonModel {
	
	var id: Int = 0
	var buttonURL: URL?
	var buttonValue: String = ""
	var buttonColor: String = ""
	var positionX: Float = 0.0
	var positionY: Float = 0.0
	var rotate: Float = 0.0
	var isShadowHidden: Bool = false
	var itemID: Int = 0
	
	var borderWidth: Float = 0.0
	var borderColor: String = ""
	
	var fontFamily: String = "HelveticaNeue"
	var fontSize: Float = 14.0
	
	init(json: JSON) {
		self.id = json["id"].intValue
		self.buttonURL = json["button_url"].url
		self.buttonValue = json["button_value"].stringValue
		self.buttonColor = json["button_color"].stringValue
		self.positionX = json["position_x"].floatValue
		self.positionY = json["position_y"].floatValue
		self.rotate = json["rotate"].floatValue
		self.isShadowHidden = json["hidden"].boolValue
		self.itemID = json["item_id"].intValue
		self.borderWidth = json["border_width"].floatValue
		self.borderColor = json["border_color"].stringValue
		
		self.fontFamily = json["button_font"].stringValue
		self.fontSize = json["button_font_size"].floatValue
	}
	
	init() {
	}
}
