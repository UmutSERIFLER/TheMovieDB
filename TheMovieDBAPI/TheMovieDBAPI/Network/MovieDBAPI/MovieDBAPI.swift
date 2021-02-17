//
//  MovieDBAPI.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 16/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import Foundation

public enum MovieDBAPI {
    case configuration
    case getTrending(type: MediaType, time: TimeWindow, page: Int)
    case getPopularTVs(page: Int)
    case getPopularMovies(page: Int)
}

fileprivate enum MovieDBServiceTitles: String {
    case movie = "movie/"
    case tv = "tv/"
    case popular = "popular?"
    case trending = "trending/"
    case configuration = "configuration?"
}

extension MovieDBAPI: EndPointType {
    
    var baseURL: URL {
        guard let url = URL(string: Credential.BaseURL) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }

    var servicePath: String {
        switch self {
        case .getPopularMovies(let pageNumber):
            return MovieDBServiceTitles.movie.rawValue + MovieDBServiceTitles.popular.rawValue + "page=\(pageNumber)&"
        case .getPopularTVs(let pageNumber):
            return MovieDBServiceTitles.tv.rawValue + MovieDBServiceTitles.popular.rawValue + "page=\(pageNumber)&"
        case .getTrending(let genre, let time, let pageNumber):
            return MovieDBServiceTitles.trending.rawValue + "\(genre.rawValue)/\(time.rawValue)?page=\(pageNumber)&"
        case .configuration:
            return MovieDBServiceTitles.configuration.rawValue
        }
    }
    
    var path: String {
        return "\(servicePath)api_key=\(Credential.API)"
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getTrending, .configuration, .getPopularMovies, .getPopularTVs:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getTrending, .configuration, .getPopularMovies, .getPopularTVs:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
}
