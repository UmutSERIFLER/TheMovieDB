//
//  CategoryCellTest.swift
//  TheMovieDBAPIProdTests
//
//  Created by Umut SERIFLER on 18/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import XCTest
@testable import TheMovieDBAPIProd

class CategoryCellTest: XCTestCase {

    func test_cell_rendersCorrectData() throws {
        let cell = CategoryCVCell()
        let trendContent = ResourceLoader.trendAll?.results.first
        cell.content = trendContent
        XCTAssertNotNil(cell.content?.title)
        XCTAssertEqual(trendContent?.id, cell.content?.id)
    }

}
