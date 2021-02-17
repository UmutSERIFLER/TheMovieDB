//
//  MovieDBAPIProvider.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 16/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import Foundation


/// Defined private error types
fileprivate enum MovieErrorTypes {
    case noNetwork
    case invalidData
    case unknownError(message: String)
    
    func getError() -> MovieDBErrorResponseModel {
        switch self {
        case .noNetwork:
            return MovieDBErrorResponseModel(error: "No network..")
        case .invalidData:
            return MovieDBErrorResponseModel(error: "Invalid Data")
        case .unknownError(let message):
            return MovieDBErrorResponseModel(error: "\(message)")
        }
    }
}


/// MovieDBAPIProviderProtocol
protocol MovieDBAPIProviderProtocol {
    func genericParser<M>(_ data: Data?, _ response: URLResponse?, _ error: Error?, completionHandler: @escaping (Result<M, MovieDBErrorResponseModel>) -> ()) where M : Decodable
    func getTrending(type: MediaType, timeSlot: TimeWindow, page: Int, completionHandler: @escaping (Result<TrendingResponseModel, MovieDBErrorResponseModel>) -> ())
    
    func getConfiguration(completionHandler: @escaping (Result<ConfigResponseModel, MovieDBErrorResponseModel>) -> ())
    
    func getPopularMovies(pageNumber: Int, completionHandler: @escaping (Result<TrendingResponseModel, MovieDBErrorResponseModel>) -> ())
    func getPopularTVs(pageNumber: Int, completionHandler: @escaping (Result<TrendingResponseModel, MovieDBErrorResponseModel>) -> ())
  //  func getCategory(completionHandler: @escaping (Result<CategoryResponseModels, MovieDBErrorResponseModel>) -> ())
}


/// MovieDBAPI Provider
struct MovieDBAPIProvider: MovieDBAPIProviderProtocol {
            
    let router = Router<MovieDBAPI>()
    
    /// Generic Parser Method for Decodable formats
    /// - Parameters:
    ///   - data: Taken Data from Model
    ///   - response: URL Response
    ///   - error: Custom Error
    ///   - completionHandler: handler for closure
    /// - Returns: Decodable/Error
    func genericParser<M>(_ data: Data?, _ response: URLResponse?, _ error: Error?, completionHandler: @escaping (Result<M, MovieDBErrorResponseModel>) -> ()) where M : Decodable {
        if error != nil {
            completionHandler(.failure(MovieErrorTypes.noNetwork.getError()))
        }
        if let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode {
            guard let responseData = data else {
                completionHandler(.failure(MovieErrorTypes.invalidData.getError())) // Data is nil
                return
            }
            do {
                let decodedModel = try JSONDecoder().decode(M.self, from: responseData)
                completionHandler(.success(decodedModel))
            } catch  {
                do {
                    let error = try JSONDecoder().decode(MovieDBErrorResponseModel.self, from: responseData)
                    completionHandler(.failure(error))
                } catch {
                    completionHandler(.failure(MovieErrorTypes.invalidData.getError()))
                }
            }
        } else {
            guard let errorData = data else {
                completionHandler(.failure(MovieErrorTypes.invalidData.getError()))
                return
            }
            do {
                let error = try JSONDecoder().decode(MovieDBErrorResponseModel.self, from: errorData)
                completionHandler(.failure(error))
            } catch {
                completionHandler(.failure(MovieErrorTypes.unknownError(message:"Parse Error").getError()))
            }
            
        }
    }
    
    func getConfiguration(completionHandler: @escaping (Result<ConfigResponseModel, MovieDBErrorResponseModel>) -> ()) {
        router.request(.configuration) { (data, response, error) in
            self.genericParser(data, response, error) { (result) in
                completionHandler(result)
            }
        }
    }
    
    /// Get Trending Method
    /// - Parameters:
    ///   - type: Genre Type - All / Movie / TV / Person
    ///   - timeSlot: Time Window for Day / Week
    ///   - page: Pagination for specified movies
    ///   - completionHandler: Result <MovieResponse,Error>
    /// - Returns: completionHandler
    func getTrending(type: MediaType = .all, timeSlot: TimeWindow = .day, page: Int = 0, completionHandler: @escaping (Result<TrendingResponseModel, MovieDBErrorResponseModel>) -> ()) {
        router.request(.getTrending(type: type, time: timeSlot, page: page)) { (data, response, error) in
            self.genericParser(data, response, error) { (result) in
                completionHandler(result)
            }
        }
    }
    
    func getPopularMovies(pageNumber: Int, completionHandler: @escaping (Result<TrendingResponseModel, MovieDBErrorResponseModel>) -> ()) {
        router.request(.getPopularMovies(page: pageNumber)) { (data, response, error) in
            self.genericParser(data, response, error) { (result) in
                completionHandler(result)
            }
        }
    }
    
    func getPopularTVs(pageNumber: Int, completionHandler: @escaping (Result<TrendingResponseModel, MovieDBErrorResponseModel>) -> ()) {
        router.request(.getPopularTVs(page: pageNumber)) { (data, response, error) in
            self.genericParser(data, response, error) { (result) in
                completionHandler(result)
            }
        }
    }
    
    
}
