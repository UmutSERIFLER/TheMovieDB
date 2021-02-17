//
//  Config.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 17/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import Foundation

/// This class is defined singleton since no one else change this data
class Config {
    static let shared = Config()
    
    var resource: ConfigResponseModel?
    
    private init(){}
}
