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
    
    @IBAction func randomButton(_ sender: UIButton) {
        makeRandom()
    }
    
    private func makeRandom() {
        if !repeatSwitch.isOn {
            
            let repeats = 10
            let interval = 0.1
            let aditionalTime = Double(repeats) * interval
            
            Random.shared.getNewValue(repeats: repeats, timeInterval: interval) {
                self.formatLabel(from: 0.5, to: 0.8, duration: 0.2)
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
        
        // MARK: - Смещаем поле ввода чтобы не закрывать его клавиатурой
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (Notification) in
            
            // if keyboard size is not available for some reason, dont do anything
            guard let keyboardSize = (Notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
            
            self.view.frame.origin.y = 0 - keyboardSize.height / 2
        }
        
        // MARK: - Возвращаем поле ввода на исходную во время скрытия клавиатуры
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { _ in
            self.view.frame.origin.y = 0
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
