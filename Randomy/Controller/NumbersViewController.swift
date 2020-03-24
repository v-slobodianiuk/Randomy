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
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        // MARK: - Смещаем поле ввода чтобы не закрывать его клавиатурой
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (Notification) in
            
            // if keyboard size is not available for some reason, dont do anything
            guard let keyboardSize = (Notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
            
            self.view.frame.origin.y = 0 - keyboardSize.height / 2
        }
        
        // MARK: - Возвращаем поле ввода на исходную во время скрытия клавиатуры
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (Notification) in
            
            self.view.frame.origin.y = 0
        }
    }
    
    @IBAction func randomButton(_ sender: UIButton) {
        
        let min = Double(minTextField.text!)!
        let max = Double(maxTextField.text!)!
        
        var randomDouble = Double(0)
        var timerTime = 0.0
        
        if !repeatSwitch.isOn {
            for _ in 1...10 {
                Timer.scheduledTimer(withTimeInterval: timerTime, repeats: false) {_ in
                    self.randomLabel.alpha = 0.5
                    randomDouble = Double.random(in: min...max)
                    if let _ = Int(self.maxTextField.text!), let _ = Int(self.minTextField.text!) {
                        UIView.animate(withDuration: 0.2) {
                            
                            self.randomLabel.text = String(format: "%.0f", randomDouble)
                            self.randomLabel.alpha = 0.8
                        }
                        
                    } else {
                        self.randomLabel.text = String(format: "%.1f", randomDouble)
                    }
                }
                timerTime += 0.1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + timerTime) {
                self.lastRandom = self.randomLabel.text!
                print(self.lastRandom)
            }

        } else {
            while (randomLabel.text! == lastRandom) {
                    self.randomLabel.alpha = 0.0
                    randomDouble = Double.random(in: min...max)
                    if let _ = Int(self.maxTextField.text!), let _ = Int(self.minTextField.text!) {
                        UIView.animate(withDuration: 1.0) {
                            
                            self.randomLabel.text = String(format: "%.0f", randomDouble)
                            self.randomLabel.alpha = 0.8
                        }
                    } else {
                        UIView.animate(withDuration: 1.0) {
                            self.randomLabel.text = String(format: "%.1f", randomDouble)
                            self.randomLabel.alpha = 0.8
                        }
                        
                    }
            }
            
            lastRandom = randomLabel.text!
        }
    }
}

extension NumbersViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            textField.backgroundColor = UIColor.systemRed.withAlphaComponent(CGFloat(0.3))
            textField.placeholder = "Введите число"
            randomButton.isHidden = true
        } else {
            textField.backgroundColor = nil
            randomButton.isHidden = false
        }



    }
}
