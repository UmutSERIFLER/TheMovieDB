//
//  MockAPIService.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 18/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import XCTest
@testable import TheMovieDBAPIProd

final class MockAPIService: MovieDBAPIProviderProtocol {

    var testForStatus = false
    var errorResponse: MovieDBErrorResponseModel!
    var trendResponse: TrendingResponseModel!
    

    func genericParser<M>(_ data: Data?, _ response: URLResponse?, _ error: Error?, completionHandler: @escaping (Result<M, MovieDBErrorResponseModel>) -> ()) where M : Decodable {

    }

    func getTrending(type: MediaType, timeSlot: TimeWindow, page: Int, completionHandler: @escaping (Result<TrendingResponseModel, MovieDBErrorResponseModel>) -> ()) {
        if testForStatus {
            completionHandler(.success(trendResponse))
        } else {
            completionHandler(.failure(errorResponse))
        }
    }

    func getConfiguration(completionHandler: @escaping (Result<ConfigResponseModel, MovieDBErrorResponseModel>) -> ()) {

    }

    func getPopularMovies(pageNumber: Int, completionHandler: @escaping (Result<TrendingResponseModel, MovieDBErrorResponseModel>) -> ()) {
        if testForStatus {
            completionHandler(.success(trendResponse))
        } else {
            completionHandler(.failure(errorResponse))
        }
    }

    func getPopularTVs(pageNumber: Int, completionHandler: @escaping (Result<TrendingResponseModel, MovieDBErrorResponseModel>) -> ()) {
        if testForStatus {
            completionHandler(.success(trendResponse))
        } else {
            completionHandler(.failure(errorResponse))
        }
    }

    func search(query: String, type: MediaType, page: Int, completionHandler: @escaping (Result<SearchResponseModel, MovieDBErrorResponseModel>) -> ()) {
     
    }







}
