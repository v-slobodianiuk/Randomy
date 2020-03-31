//
//  ListViewControllerTests.swift
//  RandomyTests
//
//  Created by Vadym on 27.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import XCTest
@testable import Randomy

class ListViewControllerTests: XCTestCase {
    
    var listVC: ListViewController!
    var targetVC: ListRandomViewController!
    var mockItem: DataModel!

    override func setUp() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ListVC") as! ListViewController
        let vc2 = storyboard.instantiateViewController(withIdentifier: "ListRandomVC") as! ListRandomViewController
        listVC = vc
        targetVC = vc2
        
        _ = listVC.view
        _ = targetVC.view
        
        mockItem = DataModel()
        mockItem.str = "Baz Bar"
        Query.shared.array.append(mockItem)
    }

    override func tearDown() {

        listVC = nil
        targetVC = nil
        mockItem = nil
    }
    
    func testPrepare() {
        
        XCTAssertNil(listVC.presentedViewController)
        
        listVC.currentRow = 0
        let segue = UIStoryboardSegue.init(identifier: "listRandom", source: listVC, destination: targetVC)
        listVC.prepare(for: segue, sender: nil)

        XCTAssertNotNil(targetVC.words)
    }
    
    func testSelectRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        
        listVC.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        self.listVC.tableView.delegate?.tableView!(self.listVC.tableView, didSelectRowAt: indexPath)
        
        XCTAssertNotNil(listVC.tableView.cellForRow(at: indexPath)?.textLabel?.text)
    }
    
}
