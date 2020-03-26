//
//  DiceViewController.swift
//  Randomy
//
//  Created by Vadym on 23.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import UIKit

class DiceViewController: UIViewController {
    
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var firstDiceImageView: UIImageView!
    @IBOutlet weak var secondDiceImageView: UIImageView!
    @IBOutlet weak var stepper: UIStepper!
    
    var dicesArray = [UIImage?] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepper.value = 2.0
        stepperLabel.text = String(format: "%.0f", stepper.value)
        
        (1...6).forEach { (img) in
            dicesArray.append(UIImage(named: "\(img)"))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Gradient.shared.initGradient(for: view)
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        makeRandom()
    }
    
    @IBAction func diceButton(_ sender: UIButton) {
        makeRandom()
    }
    
    @IBAction func stepper(_ sender: UIStepper) {
        stepperLabel.text = String(format: "%.0f", sender.value)

        switch sender.value {
        case 1.0:
            secondDiceImageView.isHidden = true
        default:
            secondDiceImageView.isHidden = false
        }
    }
    
    func makeRandom() {
        firstDiceImageView.alpha = 0.0
        secondDiceImageView.alpha = 0.0
        
        Random.shared.getNewValue(repeats: 5, timeInterval: 0.2) {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1.0) {
                    self.firstDiceImageView.image = self.dicesArray[Int.random(in: 0...5)]
                    self.firstDiceImageView.alpha = 1.0
                    self.secondDiceImageView.image = self.dicesArray[Int.random(in: 0...5)]
                    self.secondDiceImageView.alpha = 1.0
                }
            }
        }
    }
}
