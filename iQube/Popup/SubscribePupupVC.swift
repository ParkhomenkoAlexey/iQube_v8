//
//  SubscribePupupVC.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 2/9/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import Hex

final class SubscribePupupVC: BasePopupVC {
    
    @IBOutlet weak private var textDatePicker: UITextField!
    @IBOutlet weak private var myButton: UIButton!
    @IBOutlet weak private var textLabel: UILabel!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var subscribeImageView: UIImageView!
    
    private let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        closeButton.isHidden = true
        prepareDatePicker()
    }
    
    func setupVC() {
        guard let item = itemModel, let specialist = item.specialist else { return }
        textDatePicker.text = Date.dateFormatTime(date: Date())
        if let urlString = specialist.image_url, let url = URL(string: urlString) {
            subscribeImageView.kf.setImage(with: url)
        }
        nameLabel.text = specialist.fullname
        if !item.color.isEmpty {
            myButton.tintColor = UIColor(hex: item.color)
        }
    }
}

private extension SubscribePupupVC {
    
    func prepareDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        // add toolbar to textField
        textDatePicker.inputAccessoryView = toolbar
        // add datepicker to textField
        textDatePicker.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        textDatePicker.text = Date.dateFormatTime(date: datePicker.date)
        //dismiss date picker dialog
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
    }
}
