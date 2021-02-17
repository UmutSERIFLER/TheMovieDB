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
    private(set) var sectionHeaderText: String?
    private(set) var sectionHeaderView: UIView?
    
    struct RowConfig {
        var width: Int
        var height: Int
        
        init(_ width: Int = 0,_ height: Int = 0) {
            self.width = width
            self.height = height
        }
    }
    
    struct SectionConfig {
        var width: Int
        var height: Int
        var headerText: String?
        var headerView: UIView?
        
        init(_ width: Int = 0,_ height: Int = 0,_ headerText: String? = nil,_ headerView: UIView? = nil) {
            self.width = width
            self.height = height
            self.headerText = headerText
            self.headerView = headerView
        }
    }
    
    init(row: RowConfig = RowConfig(), section: SectionConfig = SectionConfig()) {
        self.cellWidth = row.width
        self.cellHeight = row.height
        self.sectionHeaderWidth = section.width
        self.sectionHeaderHeight = section.height
        self.sectionHeaderText = section.headerText
        self.sectionHeaderView = section.headerView
    }
    
}
