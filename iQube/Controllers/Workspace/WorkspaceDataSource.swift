//
//  WorkspaceDataSource.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 3/7/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit

protocol WorkspaceProtocol {
    func didSelectWorkspace(id: Int)
}

class WorkspaceDataSource: NSObject {
    var workspaceDelegate: WorkspaceProtocol?
    
    weak var applicationInfoModel: ApplicationInfoModel?
    
}

extension WorkspaceDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return applicationInfoModel?.workspaces?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkspaceCell", for: indexPath) as? WorkspaceCell, let model = applicationInfoModel?.workspaces?[indexPath.row] {
            cell.fill(model: model)
            if let appModel = applicationInfoModel {
                cell.appColor = UIColor(hex: appModel.colorButton)
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

extension WorkspaceDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let workspace = applicationInfoModel?.workspaces?[indexPath.row], let id = workspace.id else { return }
        workspaceDelegate?.didSelectWorkspace(id: id)
    }
}
