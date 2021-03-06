//
//  WeatherModel.swift
//  WeatherModels
//
//  Created by Kevin Remigio on 6/17/17.
//  Copyright © 2017 Kevin Remigio. All rights reserved.
//

import Foundation
import SwiftyJSON

class Weather {

    var weatherLocationCoordinate: LocationCoordinates? = nil
    var weatherMain: WeatherMain? = nil
    var cityName: String? = nil
    var weatherArray: [WeatherWeather] = [WeatherWeather]()
    var clouds: Clouds? = nil
    var system: Sys? = nil
    var timeStamp: Int? = nil


    init() {}
    init(json:JSON) {
        weatherMain = WeatherMain(json: json["main"])
        weatherLocationCoordinate = LocationCoordinates(json: json["coord"])
        cityName = json["name"].string
        
        for jsonObj in json["weather"].arrayValue {
            weatherArray.append(WeatherWeather(json: jsonObj))
        }
        clouds = Clouds(json: json["clouds"])
        system = Sys(json: json["sys"])
        
        timeStamp = json["dt"].int
    }

}




public class LocationCoordinates: NSObject {
    var longitude: Double? = 0
    var latitude: Double? = 0
    override init () {
        
    }
    init(json: JSON) {
        super.init()
        map(json: json)
    }
    func map(json: JSON) {
        longitude = json["lon"].double
        latitude = json["lat"].double
    }
    
}

public class WeatherMain: NSObject {
    
    var temp: Double? = 0
    var pressure: Double? = 0
    var humidity: Double? = 0
    var temp_min: Double? = 0
    var temp_max: Double? = 0
    
    override init() {
        //empty object
    }
    init(json: JSON) {
        super.init()
        map(json: json)
        
    }
    
    func map(json: JSON) {
        temp = json["temp"].double
        pressure = json["pressure"].double
        humidity = json["humidity"].double
        temp_min = json["temp_min"].double
        temp_max = json["temp_max"].double
    }
}
public class WeatherWeather: NSObject {
    var id: Double? = nil
    var main: String? = nil
    var desc: String? = nil
    var icon: String? = nil
    
    override init () {
        
    }
    init(json: JSON) {
        super.init()
        map(json: json)
    }
    func map(json: JSON) {
        id = json["id"].double
        main = json["main"].string
        desc = json["description"].string
        icon = json["icon"].string
    }
}
public class Clouds: NSObject {
    //cloudiness by percent
    var all: Int? = nil
    
    override init () {
    }
    init(json: JSON) {
        super.init()
        map(json: json)
    }
    func map(json: JSON) {
        all = json["all"].int
    }
}
public class Sys: NSObject {
    var id: Double? = nil
    var country: String? = nil
    var sunrise: Double? = nil
    var sunset: Double? = nil
    
    override init () {
        
    }
    init(json: JSON) {
        super.init()
        map(json: json)
    }
    func map(json: JSON) {
        id = json["id"].double
        country = json["country"].string
        sunrise = json["sunrise"].double
        sunset = json["sunset"].double
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
        return String(format:"%.0f", fahrenheit)
    }
    func kelvToCelc(kelvin: Double) -> String {
        let celsius = kelvin - Temperature.kelvincelsiusConversionConstant
        return String(format:"%.0f", celsius)
    }
    
}

//extension String {
//    func removeTrailingZeros(number: String) -> String {
//        let numberWithZeros = "0.0100"
//        
//        for a in numberWithZeros.characters {
//            print("\(a)")
//        }
//        return numberWithZeros
//    }
//}










