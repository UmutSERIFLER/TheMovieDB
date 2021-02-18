//
//  TabbarViewController.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 16/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import UIKit

enum TabBarItems: String {
    case List
    case Search
}

class TabbarViewController: UITabBarController, UITabBarControllerDelegate {
    
    var viewControllersArray: [UIViewController] = []
    var itemController: TabbarItemController!
    
    init(vcArray: [TabBarItems] = [.List,.Search]) {
        super.init(nibName: nil, bundle: nil)
        vcArray.forEach({viewControllersArray.append(setViewControllerForTabBarItem(itemType: $0))})
        viewControllers = viewControllersArray
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.tintColor = .blue
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
}

private extension TabbarViewController{
    
    func setViewControllerForTabBarItem(itemType: TabBarItems)-> UIViewController {
        itemController =  TabbarItemController(itemType: itemType)
        itemController.controller.tabBarItem = UITabBarItem(title: itemType.rawValue, image: UIImage(named: itemController.imageDisabled)!.withRenderingMode(.automatic), selectedImage: UIImage(named:itemController.imageEnabled)?.withRenderingMode(.automatic))
        let viewController = UINavigationController(rootViewController: itemController.controller)
        return viewController
    }
}


