//
//  ShakingTextField.swift
//  WeatherOrNot
//
//  Created by Kevin Remigio on 7/16/17.
//  Copyright © 2017 Remigio, Kevin (Contractor). All rights reserved.
//

import UIKit

class ShakingTextField: UITextField {

    func shake() {
    
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = .infinity
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y - 4))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y + 4))
        
        self.layer.add(animation, forKey: "position")
        
    }
    func stopShake() {
        self.layer.removeAllAnimations()
        self.layoutIfNeeded()
    }

}
