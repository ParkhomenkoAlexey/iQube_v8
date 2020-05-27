//
//  ARKitViewController.swift
//  ARKitDemoProject
//
//  Created by Vlad Lavrenkov on 4/18/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import ARKit
import SceneKit
import AVKit
import Hex
import SwiftIconFont


enum TypeNode: String {
	case buttonOnNode = "buttonOnNode"
	case videoNode = "videoNode"
	case shadow = "shadow"
}

class ARKitVC: UIViewController {
	
	
	//MARK: - Variables
	
	//white highlight when image is find
	var imageHighlightAction: SCNAction {
		return .sequence([
			.wait(duration: 0.25),
			.fadeOpacity(to: 0.85, duration: 0.25),
			.fadeOpacity(to: 0.15, duration: 0.25),
			.fadeOpacity(to: 0.85, duration: 0.25),
			.fadeOut(duration: 0.5),
			.removeFromParentNode()
			])
	}
	
	var currentPupop: UIViewController?
	var isCanShowPopup = true
	
	//popover
	var popoverContentController: PopoverTableView?
	var currentFeedbackItems: [FeedbackItemModel]?
	
	let avMaterial = SCNMaterial()
	
	@IBOutlet var sceneView: ARSCNView!
    @IBOutlet var dotsImageView: UIImageView!
        
	private var imageConfiguration: ARImageTrackingConfiguration?
	var imagesARReference = Set<ARReferenceImage>()
	var imagesModel = [ImageModel]()
	
	var physicalWidth: CGFloat = 0.0
	var physicalHeight: CGFloat = 0.0
	var itemWidth: CGFloat = 0.0
	var itemHeight: CGFloat = 0.0
	
	var apiManager = ApiManager()
	var imageService = ImageService()
	
	let plusButton = UIButton(frame: CGRect.zero)
	
	//MARK: - CallBacks
    var openURLCallback: ((_ buttonID: Int, _ bgID: Int)->())?
	
	//MARK: - Methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
		sceneView.delegate = self
		sceneView.session.delegate = self
		// Uncomment to show statistics such as fps and timing information
		//sceneView.showsStatistics = true
		
		let scene = SCNScene()
		sceneView.scene = scene
		setupImageDetection()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if let configuration = imageConfiguration {
			sceneView.session.run(configuration)
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		sceneView.session.pause()
	}
	
	private func setupImageDetection() {
		imageConfiguration = ARImageTrackingConfiguration()
		
		guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Images", bundle: nil) else {
			//			fatalError("Missing expected asset catalog resources.")
			return
		}
		_ = referenceImages.map { (refImage) -> Void in
			self.imagesARReference.insert(refImage)
		}
		imageConfiguration?.trackingImages = imagesARReference
	}
}

//MARK: - ARSCNViewDelegate

extension ARKitVC: ARSCNViewDelegate {
	
	func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
		if let imageAnchor = anchor as? ARImageAnchor {
			physicalWidth = imageAnchor.referenceImage.physicalSize.width
			physicalHeight = imageAnchor.referenceImage.physicalSize.height
			highlightDetection(on: node, width: physicalWidth, height: physicalHeight) {
				self.handleFoundImage(imageAnchor, node)
			}
		}
	}
	
	func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
		guard let _ = anchor as? ARImageAnchor else {return}
		removePlusButtonFromSuperView()
		node.enumerateChildNodes { (node, _) in
			prepareToRemove(node: node)
			node.removeFromParentNode()
		}
	}
	
	private func handleFoundImage(_ imageAnchor: ARImageAnchor, _ node: SCNNode) {
		
		let name = imageAnchor.referenceImage.name
		print("Я нашел фото \(name ?? "")")
		guard var model = imagesModel.filter({ return $0.imageName == name }).first else { return }
		DispatchQueue.main.async {
			HUDView.shared.showProgress(controller: self)
		}
		
		apiManager.requestGetMarker(id: model.id) { [weak self] (success, serveModel) in
			guard let self = self, let newModel = serveModel else { return }
			if success {
                self.displayDetailView(on: node, model: newModel)
			}
			model = newModel
		}
		
		openURLCallback = { [weak self] (buttonID, bgID) in
			guard let self = self else { return }
			self.apiManager.requestWebHook(userID: UserManager.shared.user.id, markerID: bgID, buttonID: buttonID)
//			self.prepareURL(model: model, buttonID: buttonID)
			
		}
	}
	
	func displayDetailView(on rootNode: SCNNode, model: ImageModel) {
		
		//цикл добавления итемов на экран
		for item in model.items {
            switch item.type {
			case .Video:
				setupVideo(rootNode: rootNode, item: item)
                break
			case .Image:
                print(item.type)
				setupImage(rootNode: rootNode, item: item)
                break
            case .Text:
                print(item.type)
                showOfferPopup(item)
            case .Gift:
                showGiftPopup(item)
            case .Price:
                showPricePopup(item)
            case .Subscribe:
                apiManager.requestGetSpecialistInfo(specialistID: item.specialistID) { [weak self] (success, specialist) in
                    guard success, let specialist = specialist else {
                        HUDView.shared.hideProgress()
                        return
                    }
                    item.specialist = specialist
//                    self?.showSubcribePopup(item)
                    self?.showEmployeePopup(item)
                }
            default:
                break
			}
            
            // check contains model buttons or not
            if !model.items.filter({ $0.type == .Button }).isEmpty {
                print("Button")
                showButtonsPopup(model)
            }
            
            HUDView.shared.hideProgress()
		}
	}
	
	// processing of presses
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }
		if touch.view == self.sceneView {
			let viewTouchLocation: CGPoint = touch.location(in: sceneView)
			guard let result = sceneView.hitTest(viewTouchLocation, options: nil).first else {
				return
			}
			
			//КОСТЫЛЬ! нажатие на кнопку, кнопка определяется по id. id это последние символы в названии кнопки
			guard let name = result.node.name else { return }
			if name.starts(with: "button") {
                let info = result.node.name?.components(separatedBy: ",")
                guard
                    let buttonInfo = info?.first,
                    let bgInfo = info?.last
                else { return }
                let buttonID = Int(buttonInfo.replacingOccurrences(of: "button", with: "")) ?? 0
                let bgID = Int(bgInfo.replacingOccurrences(of: "bgID", with: "")) ?? 0
				openURLCallback?(buttonID, bgID)
			}
			//don't work
//			if result.node.name == TypeNode.videoNode.rawValue {
//				print("Нажал на видео")
//				self.videoTapCallBack?()
//			}
		}
	}
	
}

//MARK: - ARSessionDelegate

extension ARKitVC: ARSessionDelegate {
	
	//For remove popup and stop video
	func session(_ session: ARSession, didUpdate frame: ARFrame) {
		if let anchor = frame.anchors.last {
			guard let anchorImage = anchor as? ARImageAnchor else { return }
			
			if !anchorImage.isTracked {
				session.remove(anchor: anchor)
				NotificationCenter.default.post(name: .showCloseButton, object: nil)
                if let buttomsViewController = self.presentedViewController as? ButtonsViewController {
//                    isCanShowPopup = !isCanShowPopup
                }
			}
		}
	}
	
}

private extension ARKitVC {
    
    @IBAction func pressBackButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressVolumeButton() {
        
    }
    
    @IBAction func pressFlashButton() {
       toggleFlash()
    }
    
    @IBAction func pressNextButton() {
        
    }
    
    
    func toggleFlash() {
        if let device = AVCaptureDevice.default(for: AVMediaType.video), device.hasTorch {
            do {
                try device.lockForConfiguration()
                let torchOn = !device.isTorchActive
                try device.setTorchModeOn(level: 1.0)
                device.torchMode = torchOn ? .on : .off
                device.unlockForConfiguration()
            } catch {
                print("error")
            }
        }
    }
    
}
