//
//  ResourceLoader.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 18/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import Foundation

@testable import TheMovieDBAPIDev

struct ResourceLoader {
    
    static let trendAll: TrendingResponseModel? = readFile(named: "trendAll")
    static let trendMovie: TrendingResponseModel? = readFile(named: "trendMovie")
    static let trendTV: TrendingResponseModel? = readFile(named: "trendTv")
    
    static func readFile<ModelType: Decodable>(named name: String) -> ModelType?  {
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
            return nil
        }
        
        return try? JSONDecoder().decode(ModelType.self, from: Data(contentsOf: url))

    }
}
