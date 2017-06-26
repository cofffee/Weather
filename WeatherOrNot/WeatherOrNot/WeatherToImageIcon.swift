//
//  WeatherToImageIcon.swift
//  WeatherOrNot
//
//  Created by Kevin Remigio on 6/25/17.
//  Copyright © 2017 Remigio, Kevin (Contractor). All rights reserved.
//

import Foundation

enum WeatherIcons: String {

    case cloudy
    case cloudyMoon
    case cloudySun
    case hail
    case haze
    case moon
    case sun
    case rain
    case storm
    case sunrise
    case tornado
    case snow
    
    func name () -> String {
        switch self {
        case .cloudy:
            return "Cloud"
        case .cloudyMoon:
            return "CloudyMoon"
        case .cloudySun:
            return "CloudySun"
        case .hail:
            return "Hail"
        case .haze:
            return "Haze"
        case .moon:
            return "Moon"
        case .sun:
            return "Sun"
        case .storm:
            return "Storm"
        case .sunrise:
            return "Sunrise"
        case .tornado:
            return "Tornado"
        case .snow:
            return "Snow"
        case .rain:
            return "Rain"
        }
    }

}
