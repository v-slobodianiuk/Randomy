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

    override func setUp() {
        
        testGradient = Gradient.shared
        testView = UIView()
        testView?.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        testGradient?.initGradient(for: testView!)
    }

    override func tearDown() {
        
        testGradient = nil
        testView = nil
    }
    
    func testSublayer() {
        XCTAssertEqual(testView!.layer.sublayers![0].name, "Gradient")
    }
}
