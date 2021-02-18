//
//  SearchResponseModel.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 18/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import Foundation

// MARK: - SearchResponseModel
struct SearchResponseModel: Decodable {
    var page: Int
    var results: [SearchItem]
    var totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

extension SearchResponseModel {
    mutating func updateData(result: SearchResponseModel) {
        self.results.append(contentsOf: result.results)
        self.page = result.page
        self.totalPages = result.totalPages
        self.totalResults = result.totalResults
    }
}

// MARK: - Result
struct SearchItem: Decodable {
    let backdropPath: String?
    let firstAirDate: String?
    let genreIDS: [Int]
    let id: Int?
    let name: String?
    let originCountry: [String]?
    let originalTitle: String?
    let originalLanguage: String?
    let originalName, overview: String?
    let popularity: Double
    let posterPath: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIDS = "genre_ids"
        case id, name
        case originCountry = "origin_country"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension SearchItem {
    func getContentImageURL(resolution: ConfigResponseModel.ImageResolution = .low) -> URL? {
        guard let baseURL = Config.shared.resource?.images.secure_base_url, let logoSize = Config.shared.resource?.getImageResolutionSize(size: resolution), let suffixPath = self.backdropPath else {
            return nil
        }
        return URL(string: "\(baseURL)\(logoSize)\(suffixPath)")
    }
    
    func toContentModel() -> ContentModel {
        return ContentModel(backdropPath: self.backdropPath, genreIDS: nil, voteCount: self.voteCount, firstAirDate: self.firstAirDate, originCountry: self.originCountry, posterPath: self.posterPath, voteAverage: self.voteAverage, id: self.id, overview: self.overview, name: self.name, originalName: self.originalName, popularity: self.popularity, mediaType: .all, title: nil, originalTitle: nil, video: nil, adult: nil, releaseDate: nil)
    }
}
