//
//  ContentModel.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 17/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import Foundation

struct ContentGroupModel {
    var contentType: MediaType
    var content: TrendingResponseModel
    
    init(_ type: MediaType,_ content: TrendingResponseModel) {
        self.contentType = type
        self.content = content
    }
}
