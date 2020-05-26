//
//  WorkspaceViewController.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 3/7/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
//import Kingfisher
//import Hex
import ARKit


class WorkspaceViewController: BaseViewController {
    
    // MARK: - IBOutlers:
    
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var aboutLabel: UILabel!
    @IBOutlet private weak var continueButton: UIButton!
    
    // MARK: - Properties:
    let dataSource = WorkspaceDataSource()
    
    private var imagesARReference = Set<ARReferenceImage>()
    private var imagesModel = [ImageModel]()
    private var selectedWorkspaceID: Int?
    
    // MARK: - Overrides:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        setupView()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getApplicationInfo(appId: applicationModel?.appID) { [weak self] in
            self?.mainBlock { [weak self] in
                self?.aboutLabel.text = self?.applicationModel?.descriptionApplication
                self?.setupDataSource()
            }
        }
    }
    
    override func sendButton() {
        super.sendButton()
        startARKitSceene()
    }
        
}

private extension WorkspaceViewController {

    func setupView() {
        guard let model = applicationModel else { return }
        
        logoImageView.kf.setImage(with: model.logoURL)
        let color = UIColor(hex: model.colorButton)
        continueButton.tintColor = color
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backToInitial(sender:)))
    }
    
    func setupDataSource() {
        if let appModel = applicationModel, appModel.workspaces?.count == 1 {
            selectedWorkspaceID = applicationModel?.workspaces?.first?.id
            return
        }
        dataSource.applicationInfoModel = applicationModel
        dataSource.workspaceDelegate = self
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
    }
    
    func registerCells() {
        let nib = UINib(nibName: "WorkspaceCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "WorkspaceCell")
    }
    
    func getApplicationInfo(appId: String?, completion: EmptyCompletion) {
        guard let id = appId else { return }
        networkLayer.requestGetApplicationInfo(id: id) { [weak self] (success, appInfoModel) in
            guard success else { return }
            if let _ = appInfoModel?.errorMessage {
                return
            }
            self?.applicationModel = appInfoModel
            completion?()
        }
    }
    
    @objc func backToInitial(sender: AnyObject) {
        mainBlock {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController")
            appDelegate.window?.rootViewController = vc
            appDelegate.window?.makeKeyAndVisible()
        }
    }
    
    func startARKitSceene() {
        guard let id = selectedWorkspaceID else { return }
        networkLayer.requestGetProject(id: id) { [weak self] (success, images) in
            guard let self = self else { return }
            if !success {
                DispatchQueue.main.async {
                    self.showErrorAlert(title: "Ошибка", message: "Обратитесь к администратору")
                }
                return
            }
            
            guard let images = images else { return }
            self.download(images: images) { [weak self] in
                guard let self = self else { return }
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ARKitViewController") as! ARKitVC
                vc.imagesARReference = self.imagesARReference
                vc.imagesModel = self.imagesModel
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func download(images: [ImageModel], completion: EmptyCompletion) {
        ARKitService.downloadReferencesImages(images: images) { (arImages) in
            self.imagesARReference = arImages
            self.imagesModel = images
            completion?()
        }
    }
}


extension WorkspaceViewController: WorkspaceProtocol {
    
    func didSelectWorkspace(id: Int) {
        selectedWorkspaceID = id
    }
}

