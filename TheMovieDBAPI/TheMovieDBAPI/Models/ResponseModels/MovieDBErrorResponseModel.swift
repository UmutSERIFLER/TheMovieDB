//
//  MovieDBErrorResponseModel.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 16/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import Foundation

struct MovieDBErrorResponseModel: Decodable, Error {
    var status_code: Int
    var status_message: String
    var success: Bool
    
    init(_ code: Int = 0,error message: String = "",_ status: Bool = false) {
        self.status_code = code
        self.status_message = message
        self.success = status
    }
}
