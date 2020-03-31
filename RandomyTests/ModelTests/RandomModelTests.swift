//
//  RandomModelTests.swift
//  RandomyTests
//
//  Created by Vadym on 27.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import XCTest
@testable import Randomy

class RandomModelTests: XCTestCase {
    
    var mockRandomModel: Random?
    var mockRepeats: Int?
    var mockTimeInterval: Double?
    var mockCompletion: (() -> Void)?
    var mockLabel: UILabel?
    var mockInt: Int?
    var mockString: String?
    var mockTimer: Double?

    override func setUp() {
        
        mockRandomModel = Random.shared
        mockRepeats = 5
        mockTimeInterval = 0.2
        mockTimer = Double(mockRepeats!) * mockTimeInterval!
        mockCompletion = {
            self.mockInt = 1
            self.mockString = "Baz Bar"
            self.mockLabel?.text = "\(self.mockInt!) - \(self.mockString!)"
        }
    }

    override func tearDown() {
        
        mockRandomModel = nil
        mockRepeats = nil
        mockTimeInterval = nil
        mockCompletion = nil
        mockLabel = nil
        mockInt = nil
        mockString = nil
        mockTimer = nil
    }
    
    func testGetNewValue() {
        mockRandomModel?.getNewValue(repeats: mockRepeats!, timeInterval: mockTimeInterval!, completion: mockCompletion!)
        
        XCTAssertNil(self.mockString)
        XCTAssertNil(self.mockInt)
        XCTAssertNil(self.mockLabel?.text)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + mockTimer!) {
            XCTAssertNotNil(self.mockString)
            XCTAssertNotNil(self.mockInt)
            XCTAssertNotNil(self.mockCompletion)
            XCTAssertNotNil(self.mockLabel?.text)
            
            XCTAssertEqual(self.mockString, "Baz Bar")
            XCTAssertEqual(self.mockLabel!.text, "1 - Baz Bar")
        }
    }
}
