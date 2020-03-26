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
    
    private lazy var lastRandom = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        minTextField.delegate = self
        maxTextField.delegate = self
        
        randomLabel.text = "0"
        minTextField.text = "0"
        maxTextField.text = "10"
        
        keyboardSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Gradient.shared.initGradient(for: view)
    }
    
    @IBAction func randomButton(_ sender: UIButton) {
        self.view.layer.opacity = 0.7
        makeRandom()
        
        UIView.animate(withDuration: 1.0) {
            Gradient.shared.initGradient(for: self.view)
            self.view.layer.opacity = 1.0
            self.view.layer.setNeedsDisplay()
        }
    }
    
    private func makeRandom() {
        if !repeatSwitch.isOn {
            
            let repeats = 5
            let interval = 0.1
            let aditionalTime = Double(repeats) * interval
            
            Random.shared.getNewValue(repeats: repeats, timeInterval: interval) {
                self.formatLabel(from: 0.5, to: 0.8, duration: 0.5)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + aditionalTime) {
                self.lastRandom = self.randomLabel.text!
            }
        }
        
        if repeatSwitch.isOn {
            while (randomLabel.text! == lastRandom) {
                self.formatLabel(from: 0.0, to: 0.8, duration: 1.0)
            }
            lastRandom = randomLabel.text!
        }

    }
    
    private func formatLabel(from initial: CGFloat, to final: CGFloat, duration: Double) {
        let min = Double(minTextField.text!)!
        let max = Double(maxTextField.text!)!
        
        guard max > min else { return }
        
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
    
    private func keyboardSettings() {
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        // MARK: Change View frame y position bt default when we call Keyboard
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (Notification) in
            
            // if keyboard size is not available for some reason, dont do anything
            guard let keyboardSize = (Notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
            
            self.view.frame.origin.y = 0 - keyboardSize.height / 2
        }
        
        // MARK: Set View frame y position bt default
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { _ in
            self.view.frame.origin.y = 0
        }
    }
}

extension NumbersViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
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
