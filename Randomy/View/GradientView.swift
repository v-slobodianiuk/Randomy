//
//  GradientView.swift
//  Randomy
//
//  Created by Vadym on 26.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import UIKit

struct Gradient {
    
    static let shared = Gradient()

    let gradientLayer = CAGradientLayer()
    let gradientColors = [#colorLiteral(red: 0.9176470588, green: 0.3294117647, blue: 0.3333333333, alpha: 1).cgColor, #colorLiteral(red: 0.9411764706, green: 0.4823529412, blue: 0.2470588235, alpha: 1).cgColor, #colorLiteral(red: 1, green: 0.831372549, blue: 0.3764705882, alpha: 1).cgColor]
    
    // MARK: Set gradient for view
    func initGradient(for view: UIView) {
            gradientLayer.name = "Gradient"
            // MARK: Get random color for gradient
            gradientLayer.colors = [gradientColors[Int.random(in: 0...2)], gradientColors[Int.random(in: 0...2)]]
            gradientLayer.frame = view.bounds
            gradientLayer.shouldRasterize = true
            
            view.layer.insertSublayer(gradientLayer, at: 0)
        }
}
