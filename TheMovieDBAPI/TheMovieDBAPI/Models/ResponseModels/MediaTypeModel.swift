//
//  MediaTypeModel.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 16/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import Foundation

public enum MediaType: String, Decodable {
    case all
    case movie
    case tv
    case person
}
