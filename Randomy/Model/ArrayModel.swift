//
//  ArrayModel.swift
//  Randomy
//
//  Created by Vadym on 25.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import Foundation

struct ArrayModel {
    
    var array = [String] ()
    
    mutating func convertToArray(_ listOfWords: String?) {
        if let words = listOfWords {
            array = {
                let array = words
                    .filter{!String($0)
                        .contains(" ")}
                    .components(separatedBy: ",")
                    .compactMap{String($0)}
                return array
            }()
        }
    }
}
