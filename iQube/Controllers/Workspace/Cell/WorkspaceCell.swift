//
//  WorkspaceCell.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 3/7/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit

class WorkspaceCell: UICollectionViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var borderView: UIView!
    
    var appColor = UIColor()

    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                borderView.backgroundColor = appColor
            } else {
                borderView.backgroundColor = .clear
            }
        }
    }
    
    func fill(model: WorkspaceModel) {
        nameLabel.text = model.name
    }
}
