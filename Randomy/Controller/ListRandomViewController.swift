//
//  ListRandomViewController.swift
//  Randomy
//
//  Created by Vadym on 24.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import UIKit

class ListRandomViewController: UIViewController {
    
    @IBOutlet weak var randomNameLabel: UILabel!
    
    var randomArray = [String] ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        randomNameLabel.text = randomArray.randomElement()
    }

    @IBAction func RandomNameButton(_ sender: UIButton) {
        
        var timerTime = 0.0
        
        for _ in 1...10 {
            Timer.scheduledTimer(withTimeInterval: timerTime, repeats: false) {_ in
                self.randomNameLabel.alpha = 0.0
                    UIView.animate(withDuration: 0.5) {
                        self.randomNameLabel.text = self.randomArray.randomElement()
                        self.randomNameLabel.alpha = 1.0
                    }
            }
            timerTime += 0.3
        }
    }
}
