//
//  WeatherModel.swift
//  WeatherModels
//
//  Created by Kevin Remigio on 6/17/17.
//  Copyright © 2017 Kevin Remigio. All rights reserved.
//

import Foundation

class Weather {

    var weather: WeatherType
    var temperature: Temperature!

    var humidity: String
    
    init(wthr: WeatherType, temp: Temperature, humid: String) {
        self.weather = WeatherType(rawValue: wthr.rawValue)!
        self.temperature = temp
        self.humidity = humid
    
    }

}

enum WeatherType: String {
    case Sunny
    case Rain
    case Cloudy
    case Windy
    case Storm
    case Snow
    case Thunder
    
    case Weird
    case Unknown
    case HellStorm
    case Texas
}

class Temperature {
    var fahrenheit: String!
    var celsius: String!
    var kelvin: String!
    
    static let kelvinfahrenheitConversionConstant:Double = 459.67
    static let kelvincelsiusConversionConstant:Double = 273.15
    init (kelvin: Double) {
        fahrenheit = kelvToFahr(kelvin: kelvin)
        celsius = kelvToCelc(kelvin: kelvin)
    }
    func kelvToFahr(kelvin: Double) -> String {
        let fahrenheit = (9/5) * kelvin - Temperature.kelvinfahrenheitConversionConstant
        return String(format:"%.2f", fahrenheit)
    }
    func kelvToCelc(kelvin: Double) -> String {
        let celsius = kelvin - Temperature.kelvincelsiusConversionConstant
        return String(format:"%.2f", celsius)
    }
    
}


extension String {
    func removeTrailingZeros(number: String) -> String {
        let numberWithZeros = "0.0100"
        
        for a in numberWithZeros.characters {
            print("\(a)")
        }
        return numberWithZeros
    }
}










