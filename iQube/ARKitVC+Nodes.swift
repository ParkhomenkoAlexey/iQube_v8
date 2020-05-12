//
//  ARKitViewController+setupNodes.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 7/23/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

extension ARKitVC {
	
	func setupImage(rootNode: SCNNode, item: ItemModel) {
		guard let imageURL = item.imageURL, let url = URL(string: imageURL) else { return }
		imageService.downloadImage(link: url) { (success, image) in
			if success {
				
				//размер картинки
                let pw = Float(self.physicalWidth)
                let ph = Float(self.physicalHeight)
                self.itemWidth = CGFloat(pw * (item.width / 100))
                self.itemHeight = CGFloat(ph * (item.height / 100))
                
                let detailPlane = SCNPlane(width: self.itemWidth, height: self.itemHeight)
                
                let detailNode = SCNNode(geometry: detailPlane)
                detailNode.geometry?.firstMaterial?.diffuse.contents = image
                //z верх них 0.5
                //x лево право 1
                
                //position video
                let xNum: Float = item.positionX / 2
                let x: Float = xNum//item.positionX
                // I don't know, but need add 25% size item.positionY
                let yNum: Float = (item.positionY * -1) / 2
                let y: Float = yNum + (yNum * 25 / 100)
                
                let horizontalPositionButton: Float = x / 100.0
                let verticalPositionButton: Float = (y / 100.0) / 2
                
                
                detailNode.position.x = horizontalPositionButton
                detailNode.position.z = verticalPositionButton
                detailNode.position.y = item.positionZ / 100
                
                detailNode.opacity = 0
                detailNode.eulerAngles.x = -.pi / 2
                detailNode.name = "\(item.name)"
                
                rootNode.addChildNode(detailNode)
                
                let r = item.rotation
                let rotate = CGFloat(r * (-.pi / 180))
                
                HUDView.shared.hideProgress()
				
				detailNode.runAction(.sequence([
					.rotateBy(x: 0, y: rotate, z: 0, duration: 0),
					.fadeOpacity(to: 1.0, duration: 0.5),
					])
				)
			}
		}
	}
	
	func setupVideo(rootNode: SCNNode, item: ItemModel) {
		guard let videoURL = item.videoURL else { return }
		YoutubeDirectLink.shared.getVideoLink(youtubeLink: videoURL) { [weak self] (success, obtainedVideoURL) -> (Void) in
			guard let self = self, success, let stringURL = obtainedVideoURL, let videoU = URL(string: stringURL)  else { return }
            let avPlayer = self.createAVPlayer(url: videoU)

            //размер видео
            let pw = Float(self.physicalWidth)
            let ph = Float(self.physicalHeight)
            self.itemWidth = CGFloat(pw * (item.width / 100))
            self.itemHeight = CGFloat(ph * (item.height / 100))
            
            let detailPlane = SCNPlane(width: self.itemWidth, height: self.itemHeight)
            
            let detailNode = SCNNode(geometry: detailPlane)
            detailNode.geometry?.firstMaterial?.diffuse.contents = avPlayer
            //z верх них 0.5
            //x лево право 1
            
            //position video
            let xNum: Float = item.positionX / 2
            let x: Float = xNum//item.positionX
            // I don't know, but need add 25% size item.positionY
            let yNum: Float = (item.positionY * -1) / 2
            let y: Float = yNum + (yNum * 25 / 100)
            
            let horizontalPositionButton: Float = x / 100.0
            let verticalPositionButton: Float = (y / 100.0) / 2
            
            
            detailNode.position.x = horizontalPositionButton
            detailNode.position.z = verticalPositionButton
            detailNode.position.y = item.positionZ / 100
            
            detailNode.opacity = 0
            detailNode.eulerAngles.x = -.pi / 2
            detailNode.name = "\(item.name)"
            
            rootNode.addChildNode(detailNode)
            
            let r = item.rotation
            let rotate = CGFloat(r * (-.pi / 180))
            
            HUDView.shared.hideProgress()
            
            detailNode.runAction(.sequence([
                .rotateBy(x: 0, y: rotate, z: 0, duration: 0),
                .fadeOpacity(to: 1.0, duration: 0.5),
                ])
            )
		}
	}
	
	private func createAVPlayer(url: URL) -> AVPlayer {
		let avPlayerItem = AVPlayerItem(url: url)
		let avPlayer = AVPlayer(playerItem: avPlayerItem)
		avPlayer.play()
		NotificationCenter.default.addObserver(
			forName: .AVPlayerItemDidPlayToEndTime,
			object: nil,
			queue: nil) { notification in
				avPlayer.seek(to: .zero)
				avPlayer.play()
		}
		
		return avPlayer
	}
	
	func prepareToRemove(node: SCNNode) {
		if let avPlayer = node.geometry?.firstMaterial?.diffuse.contents as? AVPlayer {
			avPlayer.pause()
		}
	}
	
	//highlight image if it was found
	func highlightDetection(on rootNode: SCNNode, width: CGFloat, height: CGFloat, completionHandler block: @escaping (() -> Void)) {
		let planeNode = SCNNode(geometry: SCNPlane(width: width, height: height))
		planeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.white
		//		planeNode.position.z += 0.5
		planeNode.opacity = 0
		planeNode.eulerAngles.x = -.pi / 2
		rootNode.addChildNode(planeNode)
		planeNode.runAction(self.imageHighlightAction) {
			block()
		}
	}
}
