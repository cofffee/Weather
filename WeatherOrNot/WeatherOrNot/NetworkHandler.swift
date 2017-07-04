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
typealias CompletionHandler = (_ available:Weather) -> Void
typealias Completionhandler = (_ ready:Forecast) -> Void

class NetworkHandler {
    
    var weather: Weather? = nil
    var forecast: Forecast? = nil
    //let sharedInstance = NetworkHandler(zip: "19143")
    
    var requestString: String = ""
    var apiID: String = "9575400c8412cb658faf53b4a3f44f82"
    var weatherAPICallType: WeatherAPIType = .weather
    var a: WeatherAPIType = .forecast
    var zip: String? = nil

    init (zip: String) {
        requestString = "http://api.openweathermap.org/data/2.5/\(weatherAPICallType.rawValue)?zip=\(zip),us&appid=\(apiID)"
        self.zip = zip
    }
    
    
    func request(completion: @escaping CompletionHandler) {
        //print("\()")
        Alamofire.request(requestString).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result

            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
                
                let json = JSON(data: data)
                self.weather = Weather(json: json)
                WeatherCache.sharedInstance.weatherCacheList["\(self.weather?.cityName ?? "")"] = Weather(json: json)
                completion(Weather(json: json)
                )}
        }
    }
    func requestForecast(completion: @escaping Completionhandler) {
        //print("\()")
        let forecastRequest = "http://api.openweathermap.org/data/2.5/\(self.a.rawValue)?zip=\(self.zip ?? "19143"),us&appid=\(self.apiID)"
        Alamofire.request(forecastRequest).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
                
                let json = JSON(data: data)
                //self.weather = Weather(json: json)
                //WeatherCache.sharedInstance.weatherCacheList["\(self.weather?.cityName ?? "")"] = Weather(json: json)
                completion(Forecast(json: json)
                )}
        }
    }

}
