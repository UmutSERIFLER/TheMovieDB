//
//  TrendingResponseModel.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 16/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import Foundation

// MARK: - TrendingResponseModel
struct TrendingResponseModel: Decodable {
    var page: Int
    var results: [ContentModel]
    var totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

extension TrendingResponseModel {
    mutating func updateData(result: TrendingResponseModel) {
        self.results.append(contentsOf: result.results)
        self.page = result.page
//        self.totalPages = result.totalPages
//        self.totalResults = result.totalResults
    }
}

// MARK: - Result
struct ContentModel: Decodable {
    let backdropPath: String?
    let genreIDS: [Double?]?
    let voteCount: Int?
    let firstAirDate: String?
    let originCountry: [String]?
    let posterPath: String?
    let voteAverage: Double?
    let id: Int?
    let overview: String?
    let name, originalName: String?
    let popularity: Double?
    let mediaType: MediaType
    let title, originalTitle: String?
    let video: Bool?
    let adult: Bool?
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case id, overview, name
        case originalName = "original_name"
        case originalTitle = "original_title"
        case popularity
        case mediaType = "media_type"
        case title
        case video
        case adult
        case releaseDate = "release_date"
    }
    
    
    
}

extension ContentModel {
    func getContentImageURL(resolution: ConfigResponseModel.ImageResolution = .low) -> URL? {
        guard let baseURL = Config.shared.resource?.images.secure_base_url, let logoSize = Config.shared.resource?.getImageResolutionSize(size: resolution), let suffixPath = self.backdropPath else {
            return nil
        }
        return URL(string: "\(baseURL)\(logoSize)\(suffixPath)")
    }
    
}
