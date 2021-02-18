//
//  HomeViewModel.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 16/02/2021.
//  Copyright (c) 2021 UmutSERIFLER. All rights reserved.

import Foundation

class HomeViewModel: ViewProtocol {
    
    var reloadViewClosure: (() -> ()) = { }
    var showAlertClosure: ((String?) -> ()) = {_ in}
    
    
    var trendContents: [Int: ContentGroupModel] = [:] {
        didSet {
            self.reloadViewClosure()
        }
    }
    var requiredContentList: [MediaType] = [.all,.movie,.tv]
    private(set) var apiService : MovieDBAPIProviderProtocol!
    
    init(_ apiService: MovieDBAPIProviderProtocol = MovieDBAPIProvider()) {
        self.apiService = apiService
    }
    
    /// This method is called firstly to get configuration from API
    func getExtendedContents() {
        if Config.shared.resource == nil {
            apiService.getConfiguration { (result) in
                switch result {
                case .success(let configResult):
                    Config.shared.resource = configResult
                    self.getPopularContents()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    /// This is added for future implementation
    /// - Parameters:
    ///   - types: Media Type Tv / Movie
    ///   - pageNumber: page Number
    ///   - timeSlot: day / week
    func getPopularContents(types: [MediaType] = [.all,.movie,.tv], pageNumber: Int = 1, timeSlot: TimeWindow = .day) {
        for (index, type) in types.enumerated() {
            apiService.getTrending(type: type, timeSlot: timeSlot, page: pageNumber) { (result) in
                switch result {
                case .success(let successResult):
                    self.trendContents.updateValue(ContentGroupModel(type, successResult), forKey: index)
                case .failure(let error):
                    self.showAlertClosure(error.localizedDescription)
                }
            }
        }
    }
    
    func getContentsWithData() -> [Int: ContentGroupModel] {
        return self.trendContents
    }
    
    func getContentCount() -> Int {
        return self.trendContents.count
    }
    
    func getContents(in section: Int) -> ContentGroupModel? {
        return self.trendContents[section]
    }
    
}
