//
//  ListRandomViewControllerTests.swift
//  RandomyTests
//
//  Created by Vadym on 28.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import XCTest
@testable import Randomy

class ListRandomViewControllerTests: XCTestCase {
    
    var listRandomVC: ListRandomViewController!

    override func setUpWithError() throws {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ListRandomVC") as! ListRandomViewController
        listRandomVC = vc
        listRandomVC.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        
        listRandomVC = nil
    }
    
    func testViewWillAppear() {
        
        let firstSublayer = listRandomVC.view.layer.sublayers![0]
        listRandomVC.words = "Baz, Bar"
        
        XCTAssertEqual(listRandomVC.randomNameLabel.text, "Name")

        listRandomVC.viewWillAppear(true)

        XCTAssertNotNil(listRandomVC.randomNameLabel.text!)
        XCTAssertNotEqual(listRandomVC.randomNameLabel.text!, "Name")
        
        XCTAssertNotEqual(firstSublayer, listRandomVC.view.layer.sublayers![0])
    }
    
    func testWords() {
        
        XCTAssertTrue(listRandomVC.arrayModel.array.isEmpty)
        
        listRandomVC.words = "Baz, Bar"
        
        XCTAssertEqual(listRandomVC.arrayModel.array.count, 2)
    }
    
    func testCancelButton() {
        let firstSublayer = listRandomVC.view.layer.sublayers![0]
        listRandomVC.randomNameButton.sendActions(for: .touchUpInside)
        
        XCTAssertNotEqual(firstSublayer, listRandomVC.view.layer.sublayers![0])
        

    }
}
