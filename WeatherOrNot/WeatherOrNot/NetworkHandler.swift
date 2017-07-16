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

// MARK:- CCNetworkHandler class

public typealias CCNetworkSuccess = (_:JSON?, _:HTTPURLResponse?) -> Void
public typealias CCNetworkFailure = (_:String, _:HTTPURLResponse?) -> Void

enum WeatherAPIType: String {
    case weather
    case forecast
}
typealias WeatherCompletion = (_ available:Weather) -> Void
typealias ForecastCompletion = (_ ready:Forecast) -> Void

typealias GenericCompletion = (_ completion:Any) -> Void

class NetworkHandler {
    
    var weather: Weather? = nil
    var forecast: Forecast? = nil
    static let sharedInstance = NetworkHandler()
    
    var requestString: String = ""
    var apiID: String = "9575400c8412cb658faf53b4a3f44f82"
    var weatherAPICallType: WeatherAPIType = .weather
    var a: WeatherAPIType = .forecast
    var zip: String? = nil
    
    init() {}
    init (zip: String) {
        requestString = "http://api.openweathermap.org/data/2.5/\(weatherAPICallType.rawValue)?zip=\(zip),us&appid=\(apiID)"
        self.zip = zip
    }
    
    
    func request(completion: @escaping WeatherCompletion) {
    
        Alamofire.request(requestString).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result

            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
                
                let json = JSON(data: data)
                self.weather = Weather(json: json)
                WeatherCache.sharedInstance.weatherCacheList["\(self.weather?.cityName ?? "")"] = Weather(json: json)
                completion(Weather(json: json))
            }
        }
    }
    func requestForecast(completion: @escaping ForecastCompletion) {
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
                completion(Forecast(json: json))
            }
        }
    }
    
    

    
    var responseJson:JSON? = nil
    
    //MARK:- Public
    
    /**
     Make request
     
     - parameter request: The URL request.
     - parameter success: Block response with JSON response.
     - parameter failed:  Block for error message.
     */
    public func request(request: URLRequestConvertible, functionName: String = #function, fileName: String = #file, success:CCNetworkSuccess, failed:@escaping CCNetworkFailure) {
        
    
        let mutableURLRequest = request.urlRequest
        


        
//        if mutableURLRequest.URL?.absoluteString == nil {
//            return
//        }
        
        Alamofire.request(mutableURLRequest!)
            .responseJSON { [unowned self](response) -> Void in
//                writelog("REQUEST: \(request.URLRequest.URLString)")
//                //TODO: REMOVE THIS DEBUG, TOO MUCH INFO !!
//                writelog("DEBUG-HTTP_RESPONSE")
//                writelog("HTTPS-STATUS-CODE:\n \(response.response?.statusCode)")
//                writelog("HTTP-REQUEST:\n \(response.request)")
//                writelog("HTTP-HEADERS:\n \(response.response?.allHeaderFields)")
//                //writelog("HTTP-BODY:\n \(response.request?.URLRequest.HTTPBody)")
//                writelog("HTTP-RESPONSE:\n \(response.response)")
//                
//                // Display line below only on development mode.
//                #if DEVELOPMENT
//                    writelog("SERVER-RESPONSE: \n \(response.result.value)\n")
//                #endif
                
                if let apiResponse = response.response {
                    
                    //self.handleStatusCode(response.result.value, response:apiResponse, requestObj: request, success: success, failed: failed)
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        print("Data: \(utf8Text)") // original server data as UTF8 string
                        
                        let json = JSON(data: data)

                    }
                    
                } else {
                    if response.response == nil  {
//                        writelog("Network issue. Nil response from request.")
//                        failed(Constants.AlertNotifications.NoInternetConnection.rawValue, nil)
                    }else {
//                        writelog("response missing response: \(response.debugDescription)")
//                        let errorString = "Http error : \(response.debugDescription)"
//                        writelog(errorString)
//                        failed(errorString, nil)
                    }
                }
        }
    }

}





enum Router: URLRequestConvertible {
    static let baseURLString = "http://api.openweathermap.org/data/2.5/\(NetworkHandler.sharedInstance.a)?zip=\(19143),us&appid=\(NetworkHandler.sharedInstance.apiID)"
    static let messageURLString = "https://int-messaging.tech360.comcast.com/comm/"
    
    
    //    static let woURLString = Constants.URLPaths.woBaseURL.value()
    
    case Weather
    case Forecast
  
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let result: (path: String, parameters: Parameters) = {
            switch self {

            default:
                return ("", ["": ""])
            }
        }()

//        let url = try Router.baseURLString.asURL()
//        //let urlRequest = NSURLRequest(url: url.appendingPathComponent(result.path))
//        let urlRequest = URLRequest(url:url)
//        //return try URLEncoding.default.encode(urlRequest as! URLRequestConvertible, with: result.parameters)
//        return urlRequest
        
        let url = try Router.baseURLString.asURL()
        let urlRequest = URLRequest(url: url)
        
        return try URLEncoding.default.encode(urlRequest, with: result.parameters)
    }
    
    var method: HTTPMethod {
        switch self {
        case .Weather:
            return .get
        case .Forecast:
            return .get
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {

        case .Weather:
            return "http://api.openweathermap.org/data/2.5/\(NetworkHandler.sharedInstance.a)?zip=\(19143),us&appid=\(NetworkHandler.sharedInstance.apiID)"

        case .Forecast:
            return "http://api.openweathermap.org/data/2.5/"
        default:
            return ""
            
        }
    }
    
    var queryParams: String {
        switch self {
            
        default:
            return ""
        }
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
                default:
            return nil
        }
    }
    
    var encoding:ParameterEncoding {
        switch self {
        case .Forecast:
            return JSONEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var timeoutInterval: TimeInterval {
        switch self {
        default:
            return 60.0
        }
    }
    

    
    var urlRequest: NSMutableURLRequest {
        let URL = NSURL(string: Router.baseURLString)!
        var request:NSMutableURLRequest
        
        switch self {

        default:
            if !self.queryParams.isEmpty {
                
                let urlComponents = NSURLComponents(string: URL.absoluteString!)
                urlComponents?.path = "\(String(describing: urlComponents?.path!))\(self.path)"
                urlComponents?.query = self.queryParams
                
                print("urlComponents.URLString: \(String(describing: urlComponents))")
                
                let url = urlComponents?.url!
                request = NSMutableURLRequest(url: url!)
            }else {
                request = NSMutableURLRequest(url: URL.appendingPathComponent(self.path)!)
            }
        }

        request.httpMethod = method.rawValue
        request.timeoutInterval = self.timeoutInterval
        //return encoding.encode(request as! URLRequestConvertible, with: self.parameters) as! NSMutableURLRequest
        do {
            return try encoding.encode(request as! URLRequestConvertible, with: parameters) as! NSMutableURLRequest
        } catch {
            // handle error
            let url: NSURL = NSURL(string:"")!
            return NSMutableURLRequest(url: url as URL)
        }
        
    }
}
