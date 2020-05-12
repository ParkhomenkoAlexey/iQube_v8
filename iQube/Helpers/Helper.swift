//
//  Helper.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 7/11/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

typealias EmptyCompletion = (()->(Void))?
typealias SuccessCompletion = ((_ success: Bool)->(Void))?

struct Const {
	struct KeychainKeys {
		static let authTokenKey = "authTokenKey"
        static let appID = "appID"
	}
}

extension Notification.Name {
	
	static let showCloseButton = Notification.Name("showCloseButton")
	static let closeCloseButton = Notification.Name("closeCloseButton")
}

extension UIColor {
	static let grayColor = UIColor(red:0.39, green:0.36, blue:0.36, alpha:1.0)
	static let blueColor = UIColor(red:0.35, green:0.49, blue:0.96, alpha:1.0)
	static let lightBlack = UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0)

}

extension URL {
	func openURL() {
		UIApplication.shared.open(self, options: [:], completionHandler: nil)
	}
}

extension String {
	
	static func formattedNumber(number: String) -> String {
		let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
		let mask = "+X(XXX)XXX-XX-XX"
		
		var result = ""
		var index = cleanPhoneNumber.startIndex
		
		for ch in mask where index < cleanPhoneNumber.endIndex {
			if ch == "X" {
				result.append(cleanPhoneNumber[index])
				index = cleanPhoneNumber.index(after: index)
			} else {
				result.append(ch)
			}
		}
		
		return result
	}
	
	
	/// remove ( ) - +
	///
	/// - Returns: string number without ( ) -
	func optimizationPhoneNumber() -> String {
		return self.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "+", with: "")
	}
	
	func encodeAsParameter() -> String {
		return self.addingPercentEncoding(withAllowedCharacters: .rfc3986Unreserved)!
	}
	
}

extension CharacterSet {
	static let rfc3986Unreserved = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~")
}

extension UIView {
	
	func curveCorners() {
		self.layer.cornerRadius = 5.0
		self.clipsToBounds = true
	}
	
}

extension UIViewController {
    
    func showErrorAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension Date {
    static func dateFormatTime(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: date)
    }
}
