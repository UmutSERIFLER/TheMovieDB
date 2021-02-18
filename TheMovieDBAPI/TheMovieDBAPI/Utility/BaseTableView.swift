//
//  BaseTableView.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 17/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {
    
    init(_ frame: CGRect = .zero,_ style: UITableView.Style = .grouped,cellArray: [UITableViewCell.Type]){
        super.init(frame: frame, style: .grouped)
        backgroundColor = .customBackgroundColor
        keyboardDismissMode = .onDrag
        translatesAutoresizingMaskIntoConstraints = false
        tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        cellArray.forEach { register($0, forCellReuseIdentifier: $0.identifier) }
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}
