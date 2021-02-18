//
//  CategoryViewTest.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 18/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import XCTest
@testable import TheMovieDBAPIProd

class CategoryViewTest: XCTestCase {
    
    func test_all() throws {
        let exp = expectation(description: "deinit")
        
        let trendAll = ResourceLoader.trendAll
        let viewModel = CategoryViewModel(trendAll)
        var sut: MockArtistView? = MockArtistView(viewModel: viewModel, forCategory: "movie")
        
        sut?.deinitCalled = {
            exp.fulfill()
        }
        DispatchQueue.global(qos: .background).async {
            sut = nil
        }
        
        waitForExpectations(timeout: 4.0)
    }

}

private class MockArtistView: CategoryViewController {
    var deinitCalled: (() -> Void)?
    deinit { deinitCalled?() }
}
