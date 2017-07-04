//
//  WeatherToImageIcon.swift
//  WeatherOrNot
//
//  Created by Kevin Remigio on 6/25/17.
//  Copyright © 2017 Remigio, Kevin (Contractor). All rights reserved.
//

import Foundation
class Icons {

    init() {}
    func getIconWith(code: Double) -> String {
        switch code {
        case 200..<300:
            return "Rain"
        case 300..<400:
            return "Rain"
        case 400..<500:
            return "CloudySun"
        case 500..<600:
            return "Rain"
        case 600..<700:
            return "Snow"
        case 700..<800:
            return "Tornado"
        case 800:
            return "Sun"
        case 801..<900:
            return "CloudySun"
        case 900..<1000:
            return "Tornado"
        default:
            return "Moon"
        }
    }
}
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
