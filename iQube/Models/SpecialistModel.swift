//
//  SpecialistModel.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 2/9/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import SwiftyJSON

class SpecialistModel {
    
    var id: Int?
    var fullname: String?
    var picture_url: String?
    var location_id: Int?
    var department_id: Int?
    var specialty: String?
    var category: String?
    var work_schedule: String?
    var is_active: Bool = false
    var phone: String?
    var image_url: String?
    var workspace_id: Int?
    
    init(_ json: JSON) {
        
        id = json["id"].int
        fullname = json["fullname"].string
        picture_url = json["picture_url"].string
        location_id = json["location_id"].int
        department_id = json["department_id"].int
        specialty = json["specialty"].string
        category = json["category"].string
        work_schedule = json["work_schedule"].string
        is_active = json["is_active"].boolValue
        phone = json["phone"].string
        image_url = json["image_url"].string
        workspace_id = json["workspace_id"].int
        
    }
}
