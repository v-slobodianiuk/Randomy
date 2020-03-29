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
    
    private static let defaultCharSet = CharacterSet(charactersIn: "/:;()&”.?![]{}#%^*+=_|~<>•\\\"")
    private static let comma = ","
    
    mutating func convertToArray(_ listOfWords: String?, withOut charSet: CharacterSet? = ArrayModel.defaultCharSet, separated: String? = ArrayModel.comma) {
        if let words = listOfWords {
            array = {
                let array = words
                    .removeCharacters(from: charSet!)
                    .components(separatedBy: separated!)
                    .filter { $0.unicodeScalars.contains{CharacterSet.letters.contains($0)} }
                return array
            }()
        }
    }
}

extension String {
    func removeCharacters(from forbiddenChars: CharacterSet) -> String {
        let passed = self.unicodeScalars.filter { !forbiddenChars.contains($0) }
        return String(String.UnicodeScalarView(passed))
    }
}
