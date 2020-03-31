//
//  RandomModelTests.swift
//  RandomyTests
//
//  Created by Vadym on 27.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import XCTest
@testable import Randomy

class ArrayModelTests: XCTestCase {
    
    var mockArrayModel: ArrayModel?
    var mockString: String?

    override func setUp() {
        
        mockArrayModel = ArrayModel()
        mockString = "Baz, Bar, Baz Bar,  Baz  , 125, #$%!,"
    }

    override func tearDown() {

        mockArrayModel = nil
        mockString = nil
    }
    
    func testConvertToArray() {
        mockArrayModel?.convertToArray(mockString)
        
        XCTAssertFalse(mockArrayModel!.array.isEmpty)
        XCTAssertEqual(mockArrayModel!.array.count, 5)
        XCTAssertEqual(mockArrayModel!.array, ["Baz", " Bar", " Baz Bar", "  Baz  ", " 125"])
    }

}
