//
//  ItemModel.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 7/22/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import SwiftyJSON

enum ModelItemType: String {
	case Image
	case Video
    case Button
    case Text
    case Gift
    case Price
    case Subscribe
    case Balance
}

enum ButtonType: String {
    case call
    case url
    case request
    case webhook
}

class ItemModel {
    
    var id: Int = 0
    var bgID: Int = 0
    var specialistID: Int = 0
    var rotation: Float = 0.0
    var width: Float = 0.0
    var height: Float = 0.0
    var btn_type: ButtonType?
    var btn_type_value: String = ""
    var border_width: Float = 0.0
    var border_color: String = ""
    var fontSize: Float = 0.0
    var font: String = ""
    var align: String = ""
    var color: String = "#410ADF"
    var background: String = ""
    var type: ModelItemType = .Video
    var text: String = ""
    var positionX: Float = 0.0
    var positionY: Float = 0.0
    var positionZ: Float = 0.0
    var name: String = ""
    var videoURL: String?
    var imageURL: String?
    var buttonURL: URL?
    var price: Double?
    var buttonText: String?
    var itemIcon: String?
    var value: Int?
    
    var specialist: SpecialistModel?
	
    init() {
    }
    
	init(json: JSON) {
		id = json["id"].intValue
        bgID = json["bg_id"].intValue
        specialistID = json["specialist_id"].intValue
        rotation = json["rotation"].floatValue
        price = json["text_price"].doubleValue
        width = json["width"].floatValue
        height = json["height"].floatValue
        btn_type = ButtonType(rawValue: json["btn_type"].stringValue) ?? .url
        btn_type_value = json["btn_type_value"].stringValue
        border_width = json["border_width"].floatValue
        border_color = json["border_color"].stringValue
        fontSize = json["fontSize"].floatValue
        font = json["font"].stringValue
        align = json["align"].stringValue
        color = json["color"].string ?? "#410ADF"
        background = json["background"].stringValue
        type = ModelItemType(rawValue: json["type"].stringValue) ?? .Video
        text = json["text"].stringValue
        positionX = json["x"].floatValue
        positionY = json["y"].floatValue
        positionZ = json["zindex"].floatValue
        bgID = json["bg_id"].intValue
        name = json["name"].stringValue
        videoURL = json["video_url"].stringValue
        imageURL = json["image_url"].stringValue
        buttonURL = URL(string: json["button_url"].stringValue)
        buttonText = json["button_text"].stringValue
        itemIcon = json["item_icon"].stringValue
        value = json["value"].intValue
	}
	
}
