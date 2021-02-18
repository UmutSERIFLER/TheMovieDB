//
//  CategoryViewModelTest.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 18/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import Foundation

import XCTest
@testable import TheMovieDBAPIProd

class CategoryViewModelTest: XCTestCase {

    private var categoryViewModel: CategoryViewModel!
    private var apiService: MockAPIService!

    func testViewModelSuccessExample() throws {
        try self.testViewModel(forStatus: true)
    }
    
    func testViewModelFailExample() throws {
        try self.testViewModel(forStatus: false)
    }
    
    func testViewModel(forStatus: Bool = false) throws {
        let apiService = MockAPIService()
        let category = ResourceLoader.trendAll
        apiService.testForStatus = forStatus
        apiService.trendResponse = category
        apiService.errorResponse = MovieDBErrorResponseModel()
        apiService.getTrending(type: .all, timeSlot: .day, page: 1) { [weak self] (result) in
            switch result {
            case .success(let successResult):
                self?.categoryViewModel = CategoryViewModel(successResult)
            case .failure(let error):
                print("")
            }
            
        }
        if forStatus {
            XCTAssertEqual(categoryViewModel.categoryResponse?.results.first?.id, category?.results.first?.id)
        } else {
            
        }

    }


}
