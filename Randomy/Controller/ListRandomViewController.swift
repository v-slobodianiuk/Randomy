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
    
    private var arrayModel = ArrayModel()
    
    var words: String? {
        didSet {
            arrayModel.convertToArray(words)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        randomNameLabel.text = arrayModel.array.randomElement()
    }

    @IBAction func RandomNameButton(_ sender: UIButton) {
        Random.shared.getNewValue(repeats: 10, timeInterval: 0.3) {
            self.randomNameLabel.alpha = 0.0
            UIView.animate(withDuration: 0.5) {
                self.randomNameLabel.text = self.arrayModel.array.randomElement()
                self.randomNameLabel.alpha = 1.0
            }
        }
    }
}
