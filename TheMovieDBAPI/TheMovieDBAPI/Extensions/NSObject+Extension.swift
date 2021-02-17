//
//  NSObject+Extension.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 16/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import Foundation

extension NSObject {
    class var identifier: String {
        return String(describing: self)
    }
}
