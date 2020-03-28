//
//  CreateListViewControllerTests.swift
//  RandomyTests
//
//  Created by Vadym on 28.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import XCTest
@testable import Randomy

class CreateListViewControllerTests: XCTestCase {
    
    var createListVC: CreateListViewController!
    var listVC: ListViewController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "createItemStoryboard") as! CreateListViewController
        let targetVC = storyboard.instantiateViewController(withIdentifier: "ListVC") as! ListViewController
        createListVC = vc
        listVC = targetVC
        
        createListVC.loadViewIfNeeded()
        listVC.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        createListVC = nil
        listVC = nil
    }
    
    func testTextViewText() {
        XCTAssertNotNil(createListVC.textView.text)
    }
    
    func testViewWillAppear() {
        createListVC.viewWillAppear(true)
        XCTAssertEqual(createListVC.textView.alpha, 0.5)
        XCTAssertEqual(createListVC.textView.layer.cornerRadius, 10)
    }
    
    func testTextViewShouldBeginEditing() {
        
        createListVC.textViewShouldBeginEditing(createListVC.textView)
        
        XCTAssertEqual(createListVC.textView.text, "")
        XCTAssertEqual(createListVC.textView.alpha, 1.0)
    }
    
    func testSaveButton() {
        
        Query.shared.array = []
        
        createListVC.textView.text = "Baz, Bar"
        
        createListVC.saveButton(createListVC.saveButton)
        
        XCTAssertEqual(createListVC.textView.text, "Baz, Bar")
        XCTAssertEqual(Query.shared.array[0].text, "Baz, Bar")
    }

}
