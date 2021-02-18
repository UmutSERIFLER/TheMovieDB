//
//  CategoryViewModel.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 17/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import Foundation

class CategoryViewModel: ViewProtocol {
    
    
    var reloadViewClosure: (() -> ()) = {}
    var showAlertClosure: ((String?) -> ()) = {_ in}
    
    private(set) var apiService : MovieDBAPIProviderProtocol!
    private(set) var categoryResponse: TrendingResponseModel? {
        didSet {
            self.reloadViewClosure()
        }
    }
    
    init(_ category: TrendingResponseModel? = nil,_ apiService: MovieDBAPIProviderProtocol = MovieDBAPIProvider()) {
        self.apiService = apiService
        self.categoryResponse = category
    }
    
    func getPopularContents(type: String?, pageNumber: Int = 1, timeSlot: TimeWindow = .day) {
        guard let typeName = type, let categoryType = MediaType(rawValue: typeName.lowercased()) else { return }
        apiService.getTrending(type: categoryType, timeSlot: timeSlot, page: pageNumber) { [weak self] (result) in
            switch result {
            case .success(let successResult):
                if self?.categoryResponse == nil {
                    self?.categoryResponse = successResult
                    return
                }
                self?.categoryResponse?.updateData(result: successResult)
            case .failure(let error):
                self?.showAlertClosure(error.localizedDescription)
            }
        }
    }
    
    func getContents() -> [ContentModel] {
        return categoryResponse?.results ?? []
    }
    
    func fetchData(indexPath: IndexPath) {
        guard let contentCount = self.categoryResponse?.results.count, let content = self.categoryResponse?.results.first else { return }
        guard let pageNumber = self.categoryResponse?.page else { return }
        if (contentCount < 15) || ((contentCount - indexPath.row) == 10) {
            print(pageNumber)
            getPopularContents(type: content.mediaType.rawValue, pageNumber: pageNumber + 1)
        }
    }
}
