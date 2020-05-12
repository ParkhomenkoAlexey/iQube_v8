//
//  BaseModel.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 3/7/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import SwiftyJSON

class BaseModel {
    
    let errorMessage: String?
    
    init(json: JSON) {
        errorMessage = json["error"].string
    }
}
