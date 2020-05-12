//
//  PopoverTableView.swift
//  iQube
//
//  Created by Vlad Lavrenkov on 8/7/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class PopoverTableView: UIViewController {

	var tableView: UITableView = UITableView()
	
	var feedbackItems: [FeedbackItemModel]?
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	var closeView:(()->())?
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		closeView?()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		prepareScrollForTableView()
	}
	
	private func prepareScrollForTableView() {
		var height: CGFloat = 0.0
		_ = tableView.visibleCells.map({
			height += $0.bounds.height
		})
		if height < 150 {
			tableView.isScrollEnabled = false
		}
	}
	
	private func setupView() {
		tableView = UITableView(frame: CGRect.zero, style: .plain)
		tableView.tableFooterView = UIView()
		tableView.separatorInset = .zero
		tableView.backgroundColor = .lightBlack
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UINib(nibName: "PopoverCell", bundle: nil), forCellReuseIdentifier: "PopoverCell")
		
		self.view.addSubview(tableView)
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
		NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0).isActive = true
		NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
		NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0).isActive = true
	}
	
	private func needCall(by phone: String?) {
		guard let phone = phone, let phoneURL = URL(string: "tel://\(phone)") else { return }
		UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
	}
	
}

extension PopoverTableView: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return feedbackItems?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PopoverCell", for: indexPath) as! PopoverCell
		if let item = feedbackItems?[indexPath.row] {
			cell.setupCell(item: item)
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let item = feedbackItems?[indexPath.row]
		switch item?.type {
		case .call?:
			needCall(by: item?.phone)
			break;
		case .buy?:
			guard let stringURL = item?.link, let url = URL(string: stringURL) else { return }
			url.openURL()
			break;
		case .none:
			break
		}
	}

}
