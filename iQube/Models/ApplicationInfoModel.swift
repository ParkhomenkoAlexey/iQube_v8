//
//  ApplicationInfoModel.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 3/7/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import SwiftyJSON

class ApplicationInfoModel: BaseModel {
    
    static var appDescription = ""
    
    var appID: String = ""
    var descriptionApplication: String?
    var textButton: String?
    var colorButton: String = ""
    var logoURL: URL?
    var workspaces: [WorkspaceModel]?
    
    override init(json: JSON) {
        super.init(json: json)
        appID = json["app_id"].stringValue
        descriptionApplication = json["about"].string
        textButton = json["btn_text"].string
        colorButton = json["btn_color"].string ?? "#410ADF"
        logoURL = json["logo_url"].url
        ApplicationInfoModel.appDescription = json["about"].string ?? ""
        workspaces = json["workspaces"].arrayValue.map {
            return WorkspaceModel(json: $0)
        }
    }
    
}
