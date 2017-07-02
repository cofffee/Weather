//
//  NetworkHandler.swift
//  WeatherOrNot
//
//  Created by Kevin Remigio on 7/1/17.
//  Copyright © 2017 Remigio, Kevin (Contractor). All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum WeatherAPIType: String {
    case weather
    case forecast
}
class NetworkHandler {
    var weather: Weather? = nil
    
    //let sharedInstance = NetworkHandler(zip: "19143")
    
    var requestString: String = ""
    var apiID: String = "9575400c8412cb658faf53b4a3f44f82"
    var weatherAPICallType: WeatherAPIType = .weather

    init (zip: String) {
        requestString = "http://api.openweathermap.org/data/2.5/\(weatherAPICallType.rawValue)?zip=\(zip),us&appid=\(apiID)"
    }
    
    
    func request() {
        //print("\()")
        Alamofire.request(requestString).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
//            if let json = response.result.value {
//                print("JSON: \(json)") // serialized json response
//                
//                self.weather = Weatther(json: json as! JSON)
//            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
                
                let json = JSON(data: data)
                self.weather = Weather(json: json)
                WeatherCache.sharedInstance.weatherCacheList["\(self.weather?.cityName ?? "")"] = Weather(json: json)
//                if let userName = json[0]["user"]["name"].string {
//                    //Now you got your value
//                print("\(WeatherCache.sharedInstance.weatherCacheList["Austin"]?.weatherMai ?? "yup")")
//                }
            }
        }
    
    }
}
