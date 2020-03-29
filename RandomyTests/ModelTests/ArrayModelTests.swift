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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        mockArrayModel = ArrayModel()
        mockString = "Baz, Bar, Baz,Bar,  Baz  ,  Bar"
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockArrayModel = nil
        mockString = nil
    }
    
    func testConvertToArray() {
        mockArrayModel?.convertToArray(mockString)
        XCTAssertEqual(mockArrayModel!.array.count, 6)
    }

}
