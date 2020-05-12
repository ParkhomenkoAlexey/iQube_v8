//
//  UserModel.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 7/24/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import KeychainSwift

typealias userID = Int

class UserModel {
	
	var id: userID = 0
	var phone: String = ""
	var name: String = ""
	var smsCode: String?
	
	var token: String? {
		return KeychainSwift().get(Const.KeychainKeys.authTokenKey)
	}
    
    var appID: String? {
        return KeychainSwift().get(Const.KeychainKeys.appID)
    }
	
}
