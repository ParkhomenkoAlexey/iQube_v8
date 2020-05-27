//
//  ARKitViewController+Popups.swift
//  ARKitDemoProject
//
//  Created by Vlad Lavrenkov on 7/5/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import SwiftEntryKit

extension ARKitVC {
	
    func showButtonsPopup(_ model: ImageModel) {
        DispatchQueue.main.async {
            if self.isCanShowPopup {
                self.isCanShowPopup = false
                guard let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "ButtonsViewController") as? ButtonsViewController else { return }
                popupVC.apiManager = self.apiManager
                popupVC.model = model
                popupVC.arkitView = self
                self.dotsImageView.isHidden = true
//                popupVC.itemModel = item
//                self.currentPupop = popupVC
                self.present(popupVC, animated: true, completion: nil)
            }
        }
    }
    
	func showGiftPopup(_ item: ItemModel) {
		HUDView.shared.hideProgress()
		DispatchQueue.main.async {
			if self.isCanShowPopup {
				self.isCanShowPopup = false
				guard let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "GiftPopupVC") as? GiftPopupVC else { return }
				popupVC.itemModel = item
                popupVC.arkitView = self
				self.currentPupop = popupVC
				self.present(popupVC, animated: true, completion: nil)
			}
		}
	}
	
	func showOfferPopup(_ item: ItemModel) {
		HUDView.shared.hideProgress()
		DispatchQueue.main.async {
			if self.isCanShowPopup {
				self.isCanShowPopup = false
				guard let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "OfferPopupVC") as? OfferPopupVC else { return }
				popupVC.itemModel = item
                popupVC.arkitView = self
				self.currentPupop = popupVC
				self.present(popupVC, animated: true, completion: nil)
			}
		}
	}
	
//	func showPricePopup(_ item: ItemModel) {
//		HUDView.shared.hideProgress()
//		DispatchQueue.main.async {
//			if self.isCanShowPopup {
//				self.isCanShowPopup = false
//				guard let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "PricePopupVC") as? PricePopupVC else { return }
//				popupVC.itemModel = item
//                popupVC.arkitView = self
//				self.currentPupop = popupVC
//                print("Price")
//				self.present(popupVC, animated: true, completion: nil)
//			}
//		}
//	} // меняю на showBuyPopup
    
    func showBuyPopup(priceModel: PriceModel) {
        HUDView.shared.hideProgress()
        
        DispatchQueue.main.async {
            if self.isCanShowPopup {
                self.isCanShowPopup = false
                let popupVC = SmallBuyAlertView(model: priceModel)
                print("can show popUp")
                SwiftEntryKit.display(entry: popupVC, using: self.setupAttributes())
            }
        }
    }
	
//    func showSubcribePopup(_ item: ItemModel) {
//        HUDView.shared.hideProgress()
//        DispatchQueue.main.async {
//            if self.isCanShowPopup {
//                self.isCanShowPopup = false
//                guard let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "SubscribePupupVC") as? SubscribePupupVC else { return }
//                popupVC.itemModel = item
//                popupVC.arkitView = self
//                self.currentPupop = popupVC
//                self.present(popupVC, animated: true, completion: nil)
//            }
//        }
//    } // меняю на showEmployeePopup
    
    func showEmployeePopup(_ item: ItemModel) {
        HUDView.shared.hideProgress()
        
        DispatchQueue.main.async {
            if self.isCanShowPopup {
                self.isCanShowPopup = false
                let popupVC = SmallEmployeeAlertView(item: item)
                print("can show popUp")
                SwiftEntryKit.display(entry: popupVC, using: self.setupAttributes())
            }
        }
    }
    
	func showThanksPopup() {
		DispatchQueue.main.async {
			if self.isCanShowPopup {
				self.isCanShowPopup = false
				guard let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "ThanksPopupVC") as? ThanksPopupVC else { return }
                popupVC.arkitView = self
				self.currentPupop = popupVC
				self.present(popupVC, animated: true, completion: nil)
			}
		}
	}
    
    func setupAttributes() -> EKAttributes {
        var attributes = EKAttributes.bottomFloat
        attributes.displayDuration = .infinity
        attributes.screenBackground = .color(color: .init(light: UIColor(white: 100.0/255.0, alpha: 0.3), dark: UIColor(white: 50.0/255.0, alpha: 0.3)))
        attributes.shadow = .active(
            with: .init(
                color: .black,
                opacity: 0.3,
                radius: 8
            )
        )
        
        attributes.lifecycleEvents.willDisappear = {
            self.isCanShowPopup = true // will disappear action goes here
            print("will disappear action goes here")
        }
        
        attributes.entryBackground = .color(color: .standardBackground)
        attributes.roundCorners = .all(radius: 16)
        
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(
            swipeable: true,
            pullbackAnimation: .jolt
        )
        
        attributes.entranceAnimation = .init(
            translate: .init(
                duration: 0.7,
                spring: .init(damping: 1, initialVelocity: 0)
            ),
            scale: .init(
                from: 1.05,
                to: 1,
                duration: 0.4,
                spring: .init(damping: 1, initialVelocity: 0)
            )
        )
        
        attributes.exitAnimation = .init(
            translate: .init(duration: 0.2)
        )
        attributes.popBehavior = .animated(
            animation: .init(
                translate: .init(duration: 0.2)
            )
        )
        
        attributes.positionConstraints.verticalOffset = 10
        attributes.statusBar = .dark
        return attributes
    }
	
}
