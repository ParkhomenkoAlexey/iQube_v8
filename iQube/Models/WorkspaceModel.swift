//
//  ProjectModel.swift
//  iQube
//
//  Created by Vlad on 12/7/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import SwiftyJSON

class WorkspaceModel {
    var id: Int?
    var name: String = ""
    
    init(json: JSON) {
        self.id = json["id"].int
        self.name = json["name"].stringValue
    }
}
