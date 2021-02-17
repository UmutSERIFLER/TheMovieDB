//
//  TabbarItemController.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 16/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import UIKit

struct TabbarItemController {
    
    let controller: UIViewController
    let imageEnabled: String
    let imageDisabled: String
    private let controllerName: String

    init(itemType: TabBarItems) {
        switch itemType {
        case .List:
            self.controllerName = HomeViewController.identifier
            self.controller = HomeViewController()
            self.imageEnabled = "movie_icon_active"
            self.imageDisabled = "movie_icon_inactive"
//        case .Search:
//            self.controllerName = SearchViewController.identifier
//            self.controller = SearchViewController()
//            self.imageEnabled = "search_active_icon"
//            self.imageDisabled = "search_inactive_icon"
        }
    }
}
