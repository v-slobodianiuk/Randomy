//
//  Random.swift
//  Randomy
//
//  Created by Vadym on 25.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import Foundation

struct Random {
    static let shared = Random()
    
    private init() {}
    
    // MARK: Method for randomize elements using Timer
    func getNewValue(repeats: Int, timeInterval: Double, completion: @escaping () -> Void) {
        
        var timerTime = 0.0
        
        // MARK: For in loop with timer for animate values
        for _ in 1...repeats {
            Timer.scheduledTimer(withTimeInterval: timerTime, repeats: false) {_ in
                completion()
            }
            timerTime += timeInterval
        }
    }
}
