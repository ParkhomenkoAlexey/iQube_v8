//
//  StoryboardVC.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 7/26/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import KeychainSwift

class StoryboardVC: BaseViewController {
	
	var apiManager = ApiManager()
	
	override func viewDidLoad() {
        apiManager.requestGetCheckUser { [weak self] (success) in
            guard let self = self else { return }
            if success {
                self.openWorkspaceController()
            } else {
                DispatchQueue.main.async {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController")
                    appDelegate.window?.rootViewController = vc
                    appDelegate.window?.makeKeyAndVisible()
                }
            }
        }
	}
	
}


private extension StoryboardVC {
    
    func openWorkspaceController() {
        guard let appId = UserManager.shared.user.appID else { return }
        networkLayer.requestGetApplicationInfo(id: appId) { (success, appInfoModel) in
            DispatchQueue.main.async {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
                let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WorkspaceNavigationController")
                if let navigation = navigationController as? UINavigationController, let controller = navigation.topViewController as? WorkspaceViewController {
                    controller.applicationModel = appInfoModel
                }
                appDelegate.window?.rootViewController = navigationController
                appDelegate.window?.makeKeyAndVisible()
            }
        }
    }
}
