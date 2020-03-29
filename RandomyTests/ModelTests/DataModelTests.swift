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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        dataModelTest = DataModel()
        dataModelTest?.str = "Baz"
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        dataModelTest = nil
    }
    
    func testModuleIsNotNil() {
        XCTAssertNotNil(dataModelTest, "dataModelTest is not Nil")
    }
    
    func testDataModel() {
        XCTAssertEqual(dataModelTest?.str, "Baz")
    }
    
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
