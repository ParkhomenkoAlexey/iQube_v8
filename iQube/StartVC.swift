//
//  ViewController.swift
//  ARKitDemoProject
//
//  Created by Vlad Lavrenkov on 4/18/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import ARKit

class StartVC: UIViewController {
    
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var progress: UIActivityIndicatorView!
    
    private var picker = UIPickerView()
    private var toolBar = UIToolbar()
    private var projects: [WorkspaceModel]? {
        didSet {
            selectedProject = projects?.first
        }
    }
    private var selectedProject: WorkspaceModel?
    
    let networkService = ARKitService()
    let apiManager = ApiManager()
    var imagesARReference = Set<ARReferenceImage>()
    var imagesModel = [ImageModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startLoading()
        
        apiManager.requestGetWorkspaceList { [weak self] (success, projects) in
            guard let self = self else { return }
            if !success {
                self.stopLoading()
                self.showErrorAlert(title: "Ошибка", message: "Обратитесь к администратору")
                return
            }
            
            self.projects = projects
            self.stopLoading()
        }
    }
    
    @IBAction func goARKitView() {
        
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.autoresizingMask = .flexibleWidth
        picker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        toolBar = UIToolbar(frame: CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(onCloseButtonTapped))
        let spacerBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        toolBar.items = [cancelButton, spacerBarButtonItem, doneButton]
        self.view.addSubview(toolBar)
    }
    
}


extension StartVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        
        startLoading()
        self.apiManager.requestGetProject(id: selectedProject?.id) { [weak self] (success, images) in
            guard let self = self else { return }
            if !success {
                DispatchQueue.main.async {
                    self.progress.stopAnimating()
                    self.progress.isHidden = true
                    self.showErrorAlert(title: "Ошибка", message: "Обратитесь к администратору")
                }
                return
            }
            
//            guard let images = images else { return }
        }
    }
    
    @objc func onCloseButtonTapped() {
        print("close")
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return projects?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let name = projects?[row].name else { return "не найден" }
        return "Проект: \(name)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let project = projects?[row] else { return }
        selectedProject = project
        print(project.name)
    }
}


private extension StartVC {
    
    func startLoading() {
        DispatchQueue.main.async {
            self.progress.startAnimating()
            self.progress.isHidden = false
            self.button.isHidden = true
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.progress.stopAnimating()
            self.progress.isHidden = true
            self.button.isHidden = false
        }
    }
    
}
