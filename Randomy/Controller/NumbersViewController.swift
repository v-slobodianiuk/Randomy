//
//  ViewController.swift
//  Randomy
//
//  Created by Vadym on 23.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import UIKit

class NumbersViewController: UIViewController {
    
    @IBOutlet weak var minTextField: UITextField!
    @IBOutlet weak var maxTextField: UITextField!
    @IBOutlet weak var randomLabel: UILabel!
    @IBOutlet weak var repeatSwitch: UISwitch!
    @IBOutlet weak var randomButton: UIButton!
    
    lazy var lastRandom = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        minTextField.delegate = self
        maxTextField.delegate = self
        
        randomLabel.text = "0"
        minTextField.text = "0"
        maxTextField.text = "10"
        randomLabel.adjustsFontSizeToFitWidth = true
        
        keyboardSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        randomLabel.alpha = 0.7
        
        Gradient.shared.initGradient(for: view)
    }
    
    // MARK: Make random by shake
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        makeRandom()
    }
    
    @IBAction func randomButton(_ sender: UIButton) {
        makeRandom()
    }
    
    // MARK: Generate random value (repeated and not repeated)
    func makeRandom() {
        if !repeatSwitch.isOn {
            
            let repeats = 5
            let interval = 0.1
            let aditionalTime = Double(repeats) * interval
            
            Random.shared.getNewValue(repeats: repeats, timeInterval: interval) {
                self.formatLabel(from: 0.5, to: 0.7, duration: 0.5)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + aditionalTime) {
                self.lastRandom = self.randomLabel.text!
            }
        }
        
        if repeatSwitch.isOn {
            while (randomLabel.text! == lastRandom) {
                self.formatLabel(from: 0.0, to: 0.7, duration: 1.0)
            }
            lastRandom = randomLabel.text!
        }
        
        self.view.layer.opacity = 0.7
        
        UIView.animate(withDuration: 1.0) {
            Gradient.shared.initGradient(for: self.view)
            self.view.layer.opacity = 1.0
            self.view.layer.setNeedsDisplay()
        }

    }
    
    // MARK: Prepare label for random
    func formatLabel(from initial: CGFloat, to final: CGFloat, duration: Double) {

        guard var min = Double(minTextField.text!.replacingOccurrences(of: ",", with: ".")) else { return }
        guard var max = Double(maxTextField.text!.replacingOccurrences(of: ",", with: ".")) else { return }
        
        if max < min {
            swapTwoValues(&min, &max)
            swapTwoValues(&minTextField.text, &maxTextField.text)
        }
        
        self.randomLabel.alpha = initial
        let randomDouble = Double.random(in: min...max)
        if let _ = Int(self.maxTextField.text!), let _ = Int(self.minTextField.text!) {
            self.randomLabel.text = String(format: "%.0f", randomDouble)
        } else {
            self.randomLabel.text = String(format: "%.1f", randomDouble)
        }
        UIView.animate(withDuration: duration) {
            self.randomLabel.alpha = final
        }
    }
    
    // MARK: Swap two values method
    func swapTwoValues<T>(_ firstValue: inout T, _ secondValue: inout T) {
        let temp = firstValue
        firstValue = secondValue
        secondValue = temp
    }
    
    // MARK: Move view frame by y for editing text fields when keyboar will apear
    func keyboardSettings() {
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        // MARK: Change View frame y position by default when we call Keyboard
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (Notification) in
            
            // if keyboard size is not available for some reason, dont do anything
            guard let keyboardSize = (Notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
            
            self.view.frame.origin.y = 0 - keyboardSize.height / 2
        }
        
        // MARK: Set View frame y position by default
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { _ in
            self.view.frame.origin.y = 0
        }
    }
}

// MARK: - UITextFieldDelegate
extension NumbersViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        // MARK: Check if text field is empty
        if textField.text == "" {
            textField.backgroundColor = UIColor.systemBackground.withAlphaComponent(CGFloat(0.7))
            textField.placeholder = "Input number"
            randomButton.isHidden = true
        } else {
            textField.backgroundColor = UIColor.clear
            randomButton.isHidden = false
        }
    }
}
