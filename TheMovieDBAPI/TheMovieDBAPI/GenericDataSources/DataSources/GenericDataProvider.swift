//
//  GenericDataProvider.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 16/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import UIKit

public protocol GenericDataProvider {
    associatedtype T
    func getHeaderView(in section: Int) -> UIView
    func getHeaderViewHeight(in section: Int) -> Int
    func numberOfSections() -> Int
    func getCellHeight(in section: Int) -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> T?
    func updateItem(at indexPath: IndexPath, value: T)
}
