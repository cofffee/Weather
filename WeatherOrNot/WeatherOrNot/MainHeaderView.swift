//
//  MainHeaderView.swift
//  WeatherOrNot
//
//  Created by Kevin Remigio on 6/25/17.
//  Copyright © 2017 Remigio, Kevin (Contractor). All rights reserved.
//

import UIKit

class MainHeaderView: UIView {
    
    var temparatureLabel: UILabel? = nil
    var temperatureHighLowLabel: UILabel? = nil
    var cityNameLabel:UILabel? = nil
    
    var weatherImage: UIImageView? = nil
    var weatherLabel:UILabel? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = CGRect(origin: .zero, size: frame.size)
        
        let weatherImageFrame: CGRect = CGRect(x: (0.5) * frame.width - (0.5) * 120, y: (0.5) * frame.height - (0.5) * 340, width: 120, height: 120)
        weatherImage = UIImageView(frame: weatherImageFrame)
        weatherImage!.image = UIImage(named: WeatherIcons.sunrise.name())
        
        let weatherLabelFrame:CGRect = CGRect(x: 0, y: weatherImage!.frame.origin.y + 4 , width: frame.width, height: 22)

        //let weatherLabelFrame:CGRect = CGRect(x: 0, y: weatherImage!.frame.size.height + weatherImage!.frame.origin.y - 16 , width: frame.width, height: 22)
        weatherLabel = UILabel(frame: weatherLabelFrame)
        weatherLabel?.font = UIFont(name: "PingFangTC-Light", size: 18.0)
        weatherLabel?.textColor = UIColor.black
        weatherLabel?.textAlignment = .center
        weatherLabel?.text = WeatherIcons.sunrise.name()

        
        let tempLabelFrame:CGRect = CGRect(x: 0, y: frame.size.height - 260 , width: frame.width, height: 200)
        temparatureLabel = UILabel(frame: tempLabelFrame)
        temparatureLabel?.font = UIFont(name: "PingFangTC-Ultralight", size: 170.0)
        temparatureLabel?.textColor = UIColor.black
        temparatureLabel?.textAlignment = .center
        temparatureLabel?.lineBreakMode = .byCharWrapping
        temparatureLabel?.text = "43°"
        
        let cityNameLabelFrame:CGRect = CGRect(x: 0, y: frame.size.height - 30.0 , width: frame.width - 8.0, height: 22)
        cityNameLabel = UILabel(frame: cityNameLabelFrame)
        cityNameLabel?.font = UIFont(name: "PingFangTC-Light", size: 15)
        cityNameLabel?.textColor = UIColor.black
        cityNameLabel?.textAlignment = .right
        cityNameLabel?.text = "Philadelphia, Pennsylvania"
        
        let temperatureHighLowLabelFrame:CGRect = CGRect(x: 8, y: frame.size.height - 30.0 , width: frame.width, height: 22)
        temperatureHighLowLabel = UILabel(frame: temperatureHighLowLabelFrame)
        temperatureHighLowLabel?.font = UIFont(name: "PingFangTC-Ultralight", size: 15)
        temperatureHighLowLabel?.textColor = UIColor.black
        temperatureHighLowLabel?.textAlignment = .left
        temperatureHighLowLabel?.text = "65°/42°"
        
        addSubview(weatherImage!)
        addSubview(weatherLabel!)
        addSubview(temparatureLabel!)
        addSubview(cityNameLabel!)
        addSubview(temperatureHighLowLabel!)
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    

}
