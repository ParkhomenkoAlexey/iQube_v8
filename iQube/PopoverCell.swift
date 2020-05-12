//
//  PopoverCell.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 8/8/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import SwiftIconFont


class PopoverCell: UITableViewCell {
	
	@IBOutlet weak var cellLabel: UILabel!
	@IBOutlet weak var cellImageVIew: UIImageView!
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.selectionStyle = .none
		self.backgroundColor = .clear
		cellLabel.textColor = .white
	}
	
	func setupCell(item: FeedbackItemModel) {
		var imageName: String?
		switch item.type {
		case .call?:
			cellLabel.text = "Позвонить"
			if let _ = fontAwesomeIconArr["phone"] {
				imageName = "phone"
			}
			
		case .buy?:
			cellLabel.text = "Купить"
			if let _ = fontAwesomeIconArr["creditcard"] {
				imageName = "creditcard"
			}
			
		default:
			break
		}
		if let imName = imageName {
			cellImageVIew.image = UIImage(from: .fontAwesome, code: imName, size: CGSize(width: 20, height: 20)).withRenderingMode(.alwaysTemplate)
		}
		
		cellImageVIew.tintColor = .white
	}
	
}
