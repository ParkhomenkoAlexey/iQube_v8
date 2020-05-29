//
//  EmployeeSegmentedControl.swift
//  iQube
//
//  Created by Алексей Пархоменко on 29.05.2020.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
protocol CustomSegmentedControlDelegate:class {
    func changeToIndex(index:Int)
}

class CustomSegmentedControl: UIView {
    private var buttonTitles:[String]!
    private var buttons: [UIButton]!
    private var selectorView: UIView!

    var textColor:UIColor = .black
    var selectorViewColor: UIColor = #colorLiteral(red: 0.2549019608, green: 0.03921568627, blue: 0.8745098039, alpha: 1)
    var selectorTextColor: UIColor = .black

    weak var delegate: CustomSegmentedControlDelegate?

    public private(set) var selectedIndex : Int = 0

    convenience init(buttonTitle:[String]) {
        self.init(frame: .zero)
        self.buttonTitles = buttonTitle
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = UIColor.white
        updateView()
    }

    func setButtonTitles(buttonTitles:[String]) {
        self.buttonTitles = buttonTitles
        self.updateView()
    }

    func setIndex(index:Int) {
        buttons.forEach({ $0.setTitleColor(textColor, for: .normal) })
        let button = buttons[index]
        selectedIndex = index
        button.setTitleColor(selectorTextColor, for: .normal)
        let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(index)
        UIView.animate(withDuration: 0.2) {
            self.selectorView.frame.origin.x = selectorPosition
        }
    }

    @objc func buttonAction(sender:UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                //let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(buttonIndex)

                selectedIndex = buttonIndex
                selectorView.backgroundColor = .clear
                self.configSelectorView(buttonIndex)
                delegate?.changeToIndex(index: 0)
                UIView.animate(withDuration: 0.3) {

                    if buttonIndex == 0 {
                    self.selectorView.frame.origin.x = (self.frame.width / 2 - self.withButton(buttonIndex)) / 2
                    } else {
                        //self.selectorView.frame.origin.x = selectorPosition + self.withButton(0)/2
                        self.selectorView.frame.origin.x = (self.frame.width / 2 -  self.withButton(buttonIndex)) / 2 + self.frame.width / 2
                    }
                }
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
    }
}

//Configuration View
extension CustomSegmentedControl {
    private func updateView() {
        createButton()
        configSelectorView(0)
        configStackView()
    }

    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }

    private func configSelectorView(_ index: Int) {
        //let selectorWidth = frame.width / CGFloat(self.buttonTitles.count )
        if index == 0 {
            buttons[1].titleLabel?.alpha = 0.3
            buttons[0].titleLabel?.alpha = 1
        } else {
            buttons[0].titleLabel?.alpha = 0.3
            buttons[1].titleLabel?.alpha = 1
        }
        selectorView = UIView(frame: CGRect(x: ((self.frame.width / 2 - withButton(index) )) / 2 , y: self.frame.height, width: withButton(index), height: 2))
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
    }

    private func withButton(_ indexButton: Int) -> CGFloat {

        let buttonWith = buttonTitles[indexButton] as NSString
        let mounth1 = [NSAttributedString.Key.font : UIFont(name: "Helvetica", size: 15)]
        let with =  buttonWith.size(withAttributes: mounth1 as [NSAttributedString.Key : Any]).width
        return with
    }

    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action:#selector(CustomSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
    }
}

