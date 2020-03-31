//
//  QueryModelTests.swift
//  RandomyTests
//
//  Created by Vadym on 27.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import XCTest
@testable import Randomy

class QueryModelTests: XCTestCase {
    
    var queryModelTest: Query?
    var mockItem: DataModel?
    var mockTextView: UITextView?
    var nsDictionary: NSDictionary?
    var path: URL?
    var dictArray: [[String:String]]?
    var queue = DispatchQueue(label: "Test queue")
    var dispatchGroup = DispatchGroup()
    
    func plistReader() {
        nsDictionary = NSDictionary(contentsOf: path!)
        let data = try! Data(contentsOf: path!)
        let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
        dictArray = plist as? [[String:String]]
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("xct.plist")
        
        queryModelTest = Query.shared
        mockItem = DataModel()
        mockTextView = UITextView()
        mockTextView?.text = "Baz Bar"
        guard let mockTextViewText = mockTextView?.text else { return }
        mockItem?.str = mockTextViewText
        guard let mockItemText = mockItem else { return }
        queryModelTest?.array = []
        queryModelTest?.array.append(mockItemText)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        mockItem = nil
        mockTextView = nil
        nsDictionary = nil
    }
    
    func testModuleIsNotNil() {
        XCTAssertNotNil(queryModelTest, "queryModelTest Not nil")
        XCTAssertNotNil(mockItem, "mockItem Not nil")
        XCTAssertNotNil(mockTextView, "mockTextView Not nil")
    }
    
    func testDataModelArrayIsNotEmpty() {
        XCTAssertFalse(queryModelTest!.array.isEmpty, "Array is not Empty")
    }

    func testDataModelArray() {
        XCTAssertEqual(queryModelTest!.array[0].str, "Baz Bar")
    }

    func testSaveData() {
        queue.async(group: dispatchGroup) {
            self.queryModelTest?.saveItems(url: self.path)
            self.plistReader()
            XCTAssertEqual(self.dictArray![0]["str"]!, "Baz Bar")
        }
    }
    
    func testLoadData() {
        dispatchGroup.notify(queue: .main) {
            self.queryModelTest?.array = []
            self.queryModelTest?.loadItems(url: self.path)
            XCTAssertEqual(self.queryModelTest!.array[0].str, "Baz Bar")
        }
    }
}
