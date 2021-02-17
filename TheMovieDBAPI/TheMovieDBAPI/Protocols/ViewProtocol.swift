//
//  ViewProtocol.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 16/02/2021.
//  Copyright (c) 2021 UmutSERIFLER. All rights reserved.
//

import Foundation

protocol ViewProtocol {
    var reloadViewClosure: (() -> ()) { get }
    var showAlertClosure: ((String?) -> ()) { get }
}
