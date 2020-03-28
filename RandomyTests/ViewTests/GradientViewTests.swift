//
//  GradientView.swift
//  RandomyTests
//
//  Created by Vadym on 27.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import XCTest
@testable import Randomy

class GradientViewTests: XCTestCase {
    
    var testView: UIView?
    
    var testGradient: Gradient?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        testGradient = Gradient.shared
        testView = UIView()
        testView?.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        testGradient?.initGradient(for: testView!)
        
        
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        testGradient = nil
        testView = nil
    }
    
    func testSublayer() {
        
        XCTAssertEqual(testView!.layer.sublayers![0].name, "Gradient")
    }
}
