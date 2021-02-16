//
//  CellConfigModel.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 16/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import UIKit

struct CellConfigModel {
    private(set) var cellHeight: Int
    private(set) var cellWidth: Int
    private(set) var sectionHeaderWidth: Int
    private(set) var sectionHeaderHeight: Int
    private(set) var sectionHeaderText: String
    private(set) var sectionHeaderView: UIView
    typealias RowConfig = (width: Int, height: Int)
    typealias SectionConfig = (width: Int, height: Int, content:(text: String, view: UIView))
    
    init(row:RowConfig = (width: 0, height: 0), section:SectionConfig = (width: 0, height: 0, content:(text: "", view: UIView()))) {
        self.cellWidth = row.width
        self.cellHeight = row.height
        self.sectionHeaderWidth = section.width
        self.sectionHeaderHeight = section.height
        self.sectionHeaderText = section.content.text
        self.sectionHeaderView = section.content.view
    }
    
}
