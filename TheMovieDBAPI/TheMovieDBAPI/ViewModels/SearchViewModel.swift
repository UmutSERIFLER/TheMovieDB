//
//  SearchViewModel.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 18/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import Foundation

class SearchViewModel: ViewProtocol {
    
    struct SearchParameter {
        var query: String
        var type: MediaType
        init(query: String = "", type: MediaType = .movie) {
            self.query = query
            self.type = type
        }
    }
    
    var reloadViewClosure: (() -> ()) = { }
    var showAlertClosure: ((String?) -> ()) = {_ in}
    var search: SearchParameter
    var searchedContents: SearchResponseModel? {
        didSet {
            self.reloadViewClosure()
        }
    }
    
    private(set) var apiService : MovieDBAPIProviderProtocol!
    
    init(_ apiService: MovieDBAPIProviderProtocol = MovieDBAPIProvider(), search: SearchParameter = SearchParameter()) {
        self.apiService = apiService
        self.search = search
    }
    
    func searchQuery(query: String = "", type: MediaType = .movie, pageNumber: Int = 1, isNewRequest: Bool = false) {
        search = SearchParameter(query: query, type: type)
        guard !search.query.isEmpty else {
            searchedContents = nil
            return
        }
        apiService.search(query: search.query, type: search.type, page: pageNumber) { [weak self] (result) in
            switch result {
            case .success(let successResult):
                if isNewRequest {
                    self?.searchedContents = successResult
                    return
                }
                self?.searchedContents?.updateData(result: successResult)
            case .failure(let error):
                self?.showAlertClosure(error.localizedDescription)
            }
        }
    }
    
    func getSearchResult() -> [SearchItem] {
        return self.searchedContents?.results ?? []
    }
    
    func fetchData(indexPath: IndexPath) {
        
        guard let contentCount = self.searchedContents?.results.count else { return }
        
        guard let pageNumber = self.searchedContents?.page else { return }
        
        if (contentCount < 25) || ((contentCount - indexPath.row) == 10) {
            searchQuery(query: search.query, type: search.type, pageNumber: pageNumber + 1)
        }
    }

    
}
