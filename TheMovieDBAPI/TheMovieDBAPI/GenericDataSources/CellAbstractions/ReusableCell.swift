//
//  ReusableCell.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 16/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import UIKit

public protocol ReusableCell: class  {
    static var reuseIdentifier: String { get }
}

public extension ReusableCell {
    static var reuseIdentifier: String { return String(describing: self) }
}
