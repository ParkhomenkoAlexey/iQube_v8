//
//  NetworkService.swift
//  ARKitDemoProject
//
//  Created by Vlad Lavrenkov on 7/5/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import ARKit
import Kingfisher

class ARKitService {
	
	static func downloadReferencesImages(images: [ImageModel], completion: @escaping((Set<ARReferenceImage>)->Void)) {
		var customReferenceSet = Set<ARReferenceImage>()
		
		let imageFetchingGroup = DispatchGroup()
		for img in images {
			let session = URLSession(configuration: .default)
			imageFetchingGroup.enter()
            guard let url = img.imageURL else {
				imageFetchingGroup.leave()
				break;
			}
			ImageCache.default.retrieveImageInDiskCache(forKey: "\(url.absoluteString)\(img.timestamp)") { result in
				switch result {
				case .success(let image):
					if let imageFromCache = image {
						let arImage = ARReferenceImage(imageFromCache.cgImage!, orientation: .up, physicalWidth: 1)
						arImage.name = img.imageName
						customReferenceSet.insert(arImage)
						imageFetchingGroup.leave()
					} else {
						fallthrough
					}
				case .failure:
					let downloadTask = session.dataTask(with: url) { (data, response, error) in
						if let e = error {
							debugPrint(e)
							imageFetchingGroup.leave()
						} else {
							if let imageData = data {
								if let image = UIImage(data: imageData) {
									
									ImageCache.default.store(image, forKey: "\(url.absoluteString)\(img.timestamp)")
									let arImage = ARReferenceImage(image.cgImage!, orientation: .up, physicalWidth: 1)
									arImage.name = img.imageName
									customReferenceSet.insert(arImage)
								}
							}
							imageFetchingGroup.leave()
						}
					}
					downloadTask.resume()
					break
				}
			}
		}
		
		imageFetchingGroup.notify(queue: .main) {
			completion(customReferenceSet)
		}
		
	}
	
}
