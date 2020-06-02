//
//  ImageModel.swift
//  ARKitDemoProject
//
//  Created by Vlad Lavrenkov on 7/9/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import SwiftyJSON

class ImageModel {
	
	var id: Int = 0
	var imageURL: URL?
	var items = [ItemModel]()
	var timestamp: Int = 0
	
	var imageName: String {
		get {
			return "\(id)"
		}
	}
	var feedbacks = [FeedbackItemModel]()
	
	init(json: JSON) {
		
		self.id = json["id"].intValue
        self.imageURL = URL(string: json["image_url"].stringValue)
		self.timestamp = json["updated_at_ts"].intValue
		for itemJSON in json["items"].arrayValue {
			let item = ItemModel(json: itemJSON)
//            item.imageURL = imag
			items.append(item)
		}
	}
}
