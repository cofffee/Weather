//
//  ForecastWeather.swift
//  WeatherOrNot
//
//  Created by Kevin Remigio on 7/3/17.
//  Copyright © 2017 Remigio, Kevin (Contractor). All rights reserved.
//

import Foundation
import SwiftyJSON

class Forecast {
    
    var city: City? = nil
    var weatherLocationCoordinate: LocationCoordinates? = nil
    var weatherMain: WeatherMain? = nil
    var countryName: String? = nil
    var code: String? = nil
    var count: Int? = 0
    var forecastArray: [ForecastForecast] = [ForecastForecast]()
    
    
    init() {}
    init(json:JSON) {
        city = City(json: json["city"])
        weatherLocationCoordinate = LocationCoordinates(json: json["coord"])
        countryName = json["country"].string
        code = json["cod"].string
        count = json["cnt"].int
        
        for jsonObj in json["list"].arrayValue {
            forecastArray.append(ForecastForecast(json: jsonObj))
        }
        
    }
}

class City {
    var id: Int? = 0
    var name: String? = ""
    init() {
        //empty object
    }
    init(json: JSON) {
        map(json: json)
        
    }
    
    func map(json: JSON) {
        id = json["id"].int
        name = json["name"].string
    }
}
class ForecastForecast {
    var dt: Int? = 0
    var main: MainForecast? = nil
    var weatherArray: [WeatherWeather] = [WeatherWeather]()
    var clouds: Clouds? = nil
    init() {
        //empty object
    }
    init(json: JSON) {
        map(json: json)
        
    }
    
    func map(json: JSON) {
        dt = json["dt"].int
        main = MainForecast(json: json["main"])
        for jsonObj in json["weather"].arrayValue {
            weatherArray.append(WeatherWeather(json: jsonObj))
        }
        clouds = Clouds(json: json["clouds"])
    }
}
class MainForecast {
    var temp: Double? = 0
    var tempMin: Double? = 0
    var tempMax: Double? = 0
    var pressure: Double? = 0
    var seaLevel: Double? = 0
    var groundLevel: Double? = 0
    var humidity: Int? = 0
    init() {
        //empty object
    }
    init(json: JSON) {
        map(json: json)
    }
    
    func map(json: JSON) {
        temp = json["temp"].double
        tempMin = json["temp_min"].double
        tempMax = json["temp_max"].double
        pressure = json["pressure"].double
        seaLevel = json["sea_level"].double
        groundLevel = json["grnd_level"].double
        humidity = json["humidity"].int
    }
}

