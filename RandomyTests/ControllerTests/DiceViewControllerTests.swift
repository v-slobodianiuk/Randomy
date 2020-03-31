//
//  DiceViewControllerTests.swift
//  RandomyTests
//
//  Created by Vadym on 28.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import XCTest
@testable import Randomy

class DiceViewControllerTests: XCTestCase {
    
    var diceVC: DiceViewController!

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DiceVC") as! DiceViewController
        diceVC = vc
        diceVC.loadViewIfNeeded()
    }

    override func tearDown() {
        
        diceVC = nil
    }
    
    func testViewDidLoad() {
        XCTAssertEqual(diceVC.stepper.value, 2.0)
        XCTAssertFalse(diceVC.dicesArray.isEmpty)
        XCTAssertNotEqual(diceVC.stepper.value, 0.0)
        XCTAssertEqual(diceVC.dicesArray.count, 6)
    }
    
    func testViewWillAppear() {
        let firstSublayer = diceVC.view.layer.sublayers![0]

        diceVC.viewWillAppear(true)
        
        XCTAssertNotEqual(firstSublayer, diceVC.view.layer.sublayers![0])
    }
    
    func testStepper() {
        
        XCTAssertFalse(diceVC.secondDiceImageView.isHidden)
 
        diceVC.stepper.value = 1.0
        diceVC.stepper(diceVC.stepper)
        
        XCTAssertTrue(diceVC.secondDiceImageView.isHidden)
    }
    
    func testMakeRandom() {
        
        diceVC.makeRandom()
        
        XCTAssertNotNil(diceVC.firstDiceImageView.image)
        XCTAssertNotNil(diceVC.secondDiceImageView.image)
        
    }

}
