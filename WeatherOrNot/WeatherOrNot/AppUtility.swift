//
//  AppUtility.swift
//  WeatherOrNot
//
//  Created by Kevin Remigio on 7/4/17.
//  Copyright © 2017 Remigio, Kevin (Contractor). All rights reserved.
//

import Foundation
import Darwin
import UIKit
class AppUtility: NSObject {
    static let sharedInstance = AppUtility()
    
    override init() {
        
    }
    func getRandomColor() -> UIColor {
        let index = arc4random() % 4
        
        switch index {
        case 0:
            return UIColor(red: 242/255, green: 122/255, blue: 85/255, alpha: 1.0)
        case 1:
            return UIColor(red: 242/255, green: 226/255, blue: 151/255, alpha: 1.0)
        case 2:
            return UIColor(red: 137/255, green: 181/255, blue: 218/255, alpha: 1.0)
        case 3:
            return UIColor(red: 97/255, green: 213/255, blue: 212/255, alpha: 1.0)
        default:
            print("How did you get here")
            return UIColor(red: 97/255, green: 213/255, blue: 212/255, alpha: 1.0)
        }
    }
}
