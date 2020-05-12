//
//  AppDelegate.swift
//  ARKitDemoProject
//
//  Created by Vlad Lavrenkov on 4/18/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import ARKit
import KeychainSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var apiManager = ApiManager()

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		print("123")
//		guard ARImageTrackingConfiguration.isSupported else {
//			fatalError("ARKit is not available on this device.")
//		}
		
		return true
	}

}
