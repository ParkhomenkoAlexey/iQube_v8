//
//  YoutubeDirectLink.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 7/11/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
//import YoutubeDirectLinkExtractor
import XCDYouTubeKit

class YoutubeDirectLink {
	
	static public let shared = YoutubeDirectLink()
	
	func getVideoLink(youtubeLink: String, completion: @escaping((_ success: Bool, _ videoLink: String?)->(Void))) {
        let youtubeId = getYoutubeId(youtubeUrl: youtubeLink)
        XCDYouTubeClient.default().getVideoWithIdentifier(youtubeId) { (video: XCDYouTubeVideo?, error: Error?) in
            if error != nil {
                completion(false, nil)
            }
            let streamURL = video?.streamURL
            completion(true, streamURL?.absoluteString)
        }
    }
}

private extension YoutubeDirectLink {
    func getYoutubeId(youtubeUrl: String) -> String? {
        return URLComponents(string: youtubeUrl)?.queryItems?.first(where: { $0.name == "v" })?.value
    }
}
