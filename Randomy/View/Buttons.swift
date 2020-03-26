//
//  Buttons.swift
//  Randomy
//
//  Created by Vadym on 26.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import UIKit

class Buttons: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()

        setCorners()
    }

    func setCorners() {
        //self.layer.masksToBounds = true
        self.layer.cornerRadius = 25
        self.alpha = 0.85
        self.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.2509803922, blue: 0.3490196078, alpha: 1)
    }
}
