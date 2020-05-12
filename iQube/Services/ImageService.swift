//
//  NetworkService.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 7/23/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class ImageService {
	
	func downloadImage(link: URL?, completion: @escaping((_ success: Bool, _ image: UIImage?)->())) {
		guard let url = link else {
			completion(false, nil)
			return
		}
		
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			if error != nil {
				completion(false, nil)
				return
			}
			guard let data = data else {
				completion(false, nil)
				return
			}
			let image = UIImage(data: data)
			completion(true, image)
		}.resume()
	}
	
}
