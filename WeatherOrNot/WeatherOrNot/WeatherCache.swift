//
//  WeatherCache.swift
//  WeatherOrNot
//
//  Created by Kevin Remigio on 7/1/17.
//  Copyright © 2017 Remigio, Kevin (Contractor). All rights reserved.
//

import Foundation

class WeatherCache {
    var weatherCacheList:[String:Weather] = [:]

    static let sharedInstance:WeatherCache = WeatherCache()
    init () { }
    
    func saveToUserDefaults() {}
    
    func fetchFromUserDefaults() {}
    
    
}
