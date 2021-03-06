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
                // MARK: Add data to array from String
                let array = words
                    // MARK: Remove restricted characters
                    .removeCharacters(from: charSet!)
                    // MARK: Separate elements by character
                    .components(separatedBy: separated!)
                    // MARK: Remove elements doesn't contain letters or numbers
                    .filter { $0.unicodeScalars.contains{CharacterSet.letters.contains($0)} || $0.unicodeScalars.contains{CharacterSet.decimalDigits.contains($0)}}
                return array
            }()
        }
    }
}

// MARK: - String Extension
extension String {
    // MARK: Use character Set for removing character from String
    func removeCharacters(from forbiddenChars: CharacterSet) -> String {
        let filtered = self.unicodeScalars.filter { !forbiddenChars.contains($0) }
        return String(String.UnicodeScalarView(filtered))
    }
}
