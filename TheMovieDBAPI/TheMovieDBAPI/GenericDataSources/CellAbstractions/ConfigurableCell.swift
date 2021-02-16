//
//  ConfigurableCell.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 16/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import UIKit

public protocol ConfigurableCell: ReusableCell {
    associatedtype T
    func configure(_ item: T, at indexPath: IndexPath)
}
