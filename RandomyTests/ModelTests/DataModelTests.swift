//
//  DataModelTests.swift
//  RandomyTests
//
//  Created by Vadym on 27.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import XCTest
@testable import Randomy

class DataModelTests: XCTestCase {
    
    var dataModelTest: DataModel?

    override func setUp() {
        
        dataModelTest = DataModel()
        dataModelTest?.str = "Baz"
    }

    override func tearDown() {
        
        dataModelTest = nil
    }
    
    func testModuleIsNotNil() {
        XCTAssertNotNil(dataModelTest, "dataModelTest is not Nil")
    }
    
    func testDataModel() {
        XCTAssertEqual(dataModelTest?.str, "Baz")
    }
}
