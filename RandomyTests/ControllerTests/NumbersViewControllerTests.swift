//
//  NumbersViewControllerTests.swift
//  RandomyTests
//
//  Created by Vadym on 27.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import XCTest
@testable import Randomy

class NumbersViewControllerTests: XCTestCase {
    
    var numberVC: NumbersViewController!

    override func setUp() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NumbersVС") as! NumbersViewController
        numberVC = vc
        _ = numberVC.view
    }

    override func tearDown() {
        
        numberVC = nil
    }
    
    func testViewWillAppear() {
        numberVC.viewWillAppear(true)
        XCTAssertEqual(numberVC.view.layer.sublayers![0].name, "Gradient")
    }
    
    func testFormatLabelFunc() {
        numberVC.randomLabel.text = "Baz Bar"
        numberVC.formatLabel(from: 0.3, to: 1.0, duration: 0.5)
        XCTAssertNotEqual(numberVC.randomLabel.text, "Baz Bar")
    }
    
    func testMakeRandom() {
        
        let repeats = 5
        let interval = 0.1
        let aditionalTime = Double(repeats) * interval
        
        numberVC.lastRandom = "Baz Bar"
        numberVC.repeatSwitch.isOn = false
        numberVC.makeRandom()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + aditionalTime) {
            self.numberVC.lastRandom = self.numberVC.randomLabel.text!
            
            XCTAssertNotEqual(self.numberVC.lastRandom, "Baz Bar")
        }
        
        numberVC.lastRandom = "Baz Bar"
        numberVC.repeatSwitch.isOn = true
        numberVC.minTextField.text = "0.0"
        numberVC.maxTextField.text = "1.0"
        numberVC.makeRandom()
        
        XCTAssertNotEqual(numberVC.randomLabel.text!, "Baz Bar")
        XCTAssertEqual(numberVC.lastRandom, numberVC.randomLabel.text!)
    }
    
    func testMakeRandomButton() {
        let firstSublayer = numberVC.view.layer.sublayers![0]
        numberVC.randomButton.sendActions(for: .touchUpInside)
        
        XCTAssertNotEqual(firstSublayer, numberVC.view.layer.sublayers![0])
    }
    
    func testTextFields() {
        numberVC.minTextField.text = ""
        numberVC.textFieldDidEndEditing(numberVC.minTextField)
        print(numberVC.minTextField.placeholder!)
        
        XCTAssertNotNil(numberVC.minTextField.placeholder!)
        XCTAssertEqual(numberVC.minTextField.backgroundColor!, UIColor.systemBackground.withAlphaComponent(CGFloat(0.7)))
        XCTAssertTrue(numberVC.randomButton.isHidden)
        
        numberVC.minTextField.placeholder = nil
        numberVC.minTextField.text = "Baz Bar"
        numberVC.textFieldDidEndEditing(numberVC.minTextField)
        XCTAssertNil(numberVC.minTextField.placeholder)
        XCTAssertEqual(numberVC.minTextField.backgroundColor!, UIColor.clear)
        XCTAssertFalse(numberVC.randomButton.isHidden)
    }
}
