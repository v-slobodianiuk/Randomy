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
    @IBOutlet weak var randomNameButton: Buttons!
    
    var arrayModel = ArrayModel()
    
    var words: String? {
        didSet {
            arrayModel.convertToArray(words)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomNameLabel.adjustsFontSizeToFitWidth = true
    }
            
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Gradient.shared.initGradient(for: view)
        randomNameLabel.alpha = 0.7
        randomNameLabel.text = arrayModel.array.randomElement()
    }
    
    // MARK: Make random by shake
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        makeRandom()
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func RandomNameButton(_ sender: UIButton) {
        makeRandom()
    }
    
    func makeRandom() {
        Random.shared.getNewValue(repeats: 5, timeInterval: 0.1) {
            self.randomNameLabel.alpha = 0.3
            UIView.animate(withDuration: 0.5) {
                self.randomNameLabel.text = self.arrayModel.array.randomElement()
                self.randomNameLabel.alpha = 0.7
            }
        }
        
        Gradient.shared.initGradient(for: view)
    }
}
