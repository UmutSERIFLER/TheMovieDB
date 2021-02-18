//
//  ChooserPopoverTableViewController.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 18/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import UIKit

class ChooserPopoverTableViewController: UITableViewController {

    typealias SelectionHandler = (String) -> Void
    
    private var values : [String]
    private let onSelect : SelectionHandler?
    
    init(searchTypes: [String] = [], onSelect : @escaping  SelectionHandler) {
        self.onSelect = onSelect
        self.values = searchTypes
        super.init(style: .plain)
        self.tableView.register(FilterOptionTableViewCell.nib, forCellReuseIdentifier: FilterOptionTableViewCell.identifier)
        self.tableView.isScrollEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateTakenData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTakenData() {
        self.preferredContentSize = CGSize(width: 150, height: (self.values.count * 40))
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.values.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let filterCell : FilterOptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: FilterOptionTableViewCell.identifier, for: indexPath) as? FilterOptionTableViewCell {
            filterCell.filterName.text = self.values[indexPath.row]
            return filterCell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true)
        onSelect?(values[indexPath.row])
    }

}
