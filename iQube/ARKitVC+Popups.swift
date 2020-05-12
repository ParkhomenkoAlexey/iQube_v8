//
//  ARKitViewController+Popups.swift
//  ARKitDemoProject
//
//  Created by Vlad Lavrenkov on 7/5/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

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
	
	func showPricePopup(_ item: ItemModel) {
		HUDView.shared.hideProgress()
		DispatchQueue.main.async {
			if self.isCanShowPopup {
				self.isCanShowPopup = false
				guard let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "PricePopupVC") as? PricePopupVC else { return }
				popupVC.itemModel = item
                popupVC.arkitView = self
				self.currentPupop = popupVC
				self.present(popupVC, animated: true, completion: nil)
			}
		}
	}
	
    func showSubcribePopup(_ item: ItemModel) {
        HUDView.shared.hideProgress()
        DispatchQueue.main.async {
            if self.isCanShowPopup {
                self.isCanShowPopup = false
                guard let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "SubscribePupupVC") as? SubscribePupupVC else { return }
                popupVC.itemModel = item
                popupVC.arkitView = self
                self.currentPupop = popupVC
                self.present(popupVC, animated: true, completion: nil)
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
	
}
