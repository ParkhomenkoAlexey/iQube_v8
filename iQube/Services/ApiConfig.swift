//
//  ApiConfig.swift
//  ARKitDemoProject
//
//  Created by Vlad Lavrenkov on 7/9/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation

enum ApiConfig: String {
	
	static let serverURL = "https://iqdesk.ru"
	
	//if / for last char in text then it is post request
    // FIXME: - need delete
	case getImages = "api/mobile/bg/list/?workspace_id="
    case getApplicationInfo = "api/mobile/app/get?app_id="
	case getImage = "api/mobile/bg/get?bg_id=" //post request for get one item
	case getProject = "api/mobile/project/get?id="
    case getSpecialist = "api/mobile/specialist/get?id="
    
	case auth = "api/mobile/auth"
    case smsCode = "api/mobile/confirm_code"
	
    case projectList = "api/mobile/project/list"
    case workspaceList = "api/mobile/workspace/list"
    
    case checkUserByToken = "api/mobile/check_token"
	
	case webHook = "api/mobile/stat/add"
	
	var url: String {
		return ApiConfig.url(raw: self.rawValue)
	}
	
	static func url(raw: String) -> String {
		return "\(ApiConfig.serverURL)/\(raw)"
	}
}
