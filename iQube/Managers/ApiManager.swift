//
//  ApiManager.swift
//  ARKitDemoProject
//
//  Created by Vlad Lavrenkov on 7/9/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import SwiftyJSON
import KeychainSwift

class ApiManager {
    
    func requestGetWorkspaceList(completion: @escaping ((_ success: Bool, _ projects: [WorkspaceModel]?)->())) {
        guard let url = URL(string: ApiConfig.workspaceList.url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        print(#function)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let jsonData = self.getJSONFromRequest(data, response, error) else {
                completion(false, nil)
                return
            }
            
            let projects = jsonData.arrayValue.map { return WorkspaceModel(json: $0) }
            
            completion(true, projects)
        }.resume()
    }
    
    
    func requestGetCheckUser(completion: @escaping ((_ success: Bool)->())) {
        guard let url = URL(string: ApiConfig.auth.url) else { return }
        let user = UserManager.shared.user
        guard let token = user.token else { return }
        let param = ["token": token ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = generateParameters(param: param).data(using: String.Encoding.utf8)
        
        print(#function)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let jsonData = self.getJSONFromRequest(data, response, error) else {
                completion(false)
                return
            }
            
            let status = jsonData["status"].boolValue
            let userID = jsonData["user_id"].int
            user.id = userID ?? 0
            completion(status)
            
        }.resume()
    }
    
    //request all data
    func requestGetImages(completion: @escaping ((_ success: Bool, _ images: [ImageModel])->())) {
        
        guard let url = URL(string: ApiConfig.getImages.url) else { return }
        //        let param = ["token": "1234"]
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        //        request.httpBody = generateParameters(param: param).data(using: String.Encoding.utf8)
        
        print(#function)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            var images = [ImageModel]()
            
            guard let jsonData = self.getJSONFromRequest(data, response, error) else {
                completion(false, images)
                return
            }
            
            for imageJSON in jsonData.arrayValue {
                let image = ImageModel(json: imageJSON)
                images.append(image)
            }
            
            completion(true, images)
            
        }.resume()
    }
    
    func requestGetApplicationInfo(id: String, completion: @escaping ((_ success: Bool, _ appInfo: ApplicationInfoModel?)->())) {
        guard let url = URL(string: ApiConfig.getApplicationInfo.url+"\(id)") else { return }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        print(#function)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let jsonData = self.getJSONFromRequest(data, response, error) else {
                completion(false, nil)
                return
            }
            
            let appInfo = ApplicationInfoModel(json: jsonData)
            completion(true, appInfo)
        }.resume()
    }
    
    //request data for one item
    func requestGetMarker(id: Int, completion: @escaping ((_ success: Bool, _ marker: ImageModel?)->())) {
        guard let url = URL(string: ApiConfig.getImage.url+"\(id)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        print(#function)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let jsonData = self.getJSONFromRequest(data, response, error) else {
                completion(false, nil)
                return
            }
            
            let image = ImageModel(json: jsonData)
            completion(true, image)
            
        }.resume()
    }
    
    func requestGetSpecialistInfo(specialistID id: Int, completion: @escaping ((_ success: Bool, _ specialist: SpecialistModel?)->())) {
        guard let url = URL(string: ApiConfig.getSpecialist.url+"\(id)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        print(#function)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let jsonData = self.getJSONFromRequest(data, response, error) else {
                completion(false, nil)
                return
            }
            
            let specialistModel = SpecialistModel(jsonData)
            completion(true, specialistModel)
            
        }.resume()
    }
    
    func requestGetProject(id: Int?, completion: @escaping ((_ success: Bool, _ images: [ImageModel]?)->())) {
        guard let id = id, let url = URL(string: ApiConfig.getImages.url+"\(id)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        print(#function)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let jsonData = self.getJSONFromRequest(data, response, error) else {
                completion(false, nil)
                return
            }
            
            let images = jsonData.arrayValue.map {
                return ImageModel(json: $0)
            }
            
            completion(true, images)
            
        }.resume()
    }
    
    
    /// Register user
    ///
    /// - Parameter completion: bool value.
    func requestAuth(completion: @escaping ((_ success: Bool, _ userID: Int?)->())) {
        let user = UserManager.shared.user
        guard let url = URL(string: ApiConfig.auth.url) else { return }
        var param = [
            "phone": user.phone.optimizationPhoneNumber(),
            "token": "1234"
        ]
        if !user.name.isEmpty {
            param["name"] = user.name
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = generateParameters(param: param).data(using: String.Encoding.utf8)
        
        print(#function)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let jsonData = self.getJSONFromRequest(data, response, error) else {
                completion(false, nil)
                return
            }
            
            let status = jsonData["status"].boolValue
            let userID = jsonData["user_id"].int
            completion(status, userID)
            
        }.resume()
    }
    
    func requestConfirmCode(code: String, userID: Int, completion: @escaping ((_ success: Bool)->())) {
        guard let url = URL(string: ApiConfig.smsCode.url) else { return }
        let param: [String: String] = [
            "code" : code,
            "user_id": userID.description,
            "token": "1234"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = generateParameters(param: param).data(using: String.Encoding.utf8)
        
        print(#function)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let jsonData = self.getJSONFromRequest(data, response, error) else {
                completion(false)
                return
            }
            
            let status = jsonData["status"].boolValue
            let token = jsonData["token"].stringValue
            KeychainSwift().set(token, forKey: Const.KeychainKeys.authTokenKey)
            completion(status)
        }.resume()
    }
    
    /// Request User Tap Button. If user tap button on market then need send this request for server
    ///
    /// - Parameters:
    ///   - userID: Int value
    ///   - markerID: Int value
    ///   - buttonID: Int value
    func requestWebHook(userID: Int, markerID: Int, buttonID: Int) {
        guard let url = URL(string: ApiConfig.webHook.url) else {
            return
        }
        let param = [
            "marker_id":"\(markerID)",
            "button_id":"\(buttonID)",
            "user_id":"\(userID)",
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = generateParameters(param: param).data(using: String.Encoding.utf8)
        
        print(#function)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let _ = self.getJSONFromRequest(data, response, error) else { return }
        }.resume()
    }
}


//MARK: -
extension ApiManager {
    //generate parameters for post request
    private func generateParameters(param:[String: String]) -> String {
        var paramString = ""
        if param.count > 0 {
            paramString += param.map { (key: String, value: String) -> String in
                return key + "=" + value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            }.joined(separator: "&")
        }
        return paramString
    }
    
    //parse data to json
    private func getJSONFromRequest(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> JSON? {
        if let _ = error {
            return nil
        }
        guard let data = data else {
            return nil
        }
        let str = String(decoding: data, as: UTF8.self)
//        print("JSON: \(str)")
        guard let jsonData = try? JSON(data: data) else {
            return nil
        }
        
        return jsonData
    }
}
