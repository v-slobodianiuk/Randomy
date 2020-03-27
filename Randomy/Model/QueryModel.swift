//
//  QueryModel.swift
//  Randomy
//
//  Created by Vadym on 25.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import Foundation

protocol QueryDataDelegate {
    func reloadItems()
}

struct Query {
    
    private init() {}
    static var shared = Query()
    var array = [DataModel] ()
    
    private static let dataFilePAth = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("list_of_words.plist")
    
    func saveItems(url: URL? = Query.dataFilePAth) {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(array)
            try data.write(to: url!)
        } catch {
            print("Error encoding item array, \(error)")
        }
    }
    
    mutating func loadItems(url: URL? = Query.dataFilePAth) {
        
        if let data = try? Data(contentsOf: url!) {
            let decoder = PropertyListDecoder()
            
            do {
                array = try decoder.decode([DataModel].self, from: data)
            } catch {
                print("Error decoding items in array, \(error)")
            }
        }
    }
}
