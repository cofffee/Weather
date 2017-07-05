//
//  ForecastCollectionViewCell.swift
//  WeatherOrNot
//
//  Created by Kevin Remigio on 7/4/17.
//  Copyright © 2017 Remigio, Kevin (Contractor). All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    var weatherLabel: UILabel? = nil
    var weatherImage: UIImageView? = nil
    var tempLabel: UILabel? = nil
    var highLowTempLabel: UILabel? = nil
    var timeLabel: UILabel? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let weatherLabelFrame = CGRect(x: 0, y: 4 , width: frame.size.width, height: 18)
        weatherLabel = UILabel(frame: weatherLabelFrame)
        weatherLabel?.font = UIFont(name: "PingFangTC-Light", size: 15)
        weatherLabel?.textColor = UIColor.white
        weatherLabel?.textAlignment = .center
        weatherLabel?.lineBreakMode = .byCharWrapping
        weatherLabel?.text = "-"
        
        let timeLabelFrame = CGRect(x: 0, y: 28 , width: frame.size.width, height: 18)
        timeLabel = UILabel(frame: timeLabelFrame)
        timeLabel?.font = UIFont(name: "PingFangTC-Light", size: 15)
        timeLabel?.textColor = UIColor.black
        timeLabel?.textAlignment = .center
        timeLabel?.text = "Now"
        
        let tempLabelFrame = CGRect(x: 0, y: 48, width: frame.size.width, height: 50)
        tempLabel = UILabel(frame: tempLabelFrame)
        tempLabel?.font = UIFont(name: "PingFangTC-Light", size: 48)
        tempLabel?.textColor = UIColor.white
        tempLabel?.textAlignment = .center
        tempLabel?.lineBreakMode = .byCharWrapping
        tempLabel?.text = "1"
        
        let weatherImageFrame: CGRect = CGRect(x: (0.5) * frame.width - (0.5) * 65, y: frame.size.height - 74, width: 65, height: 65)
        weatherImage = UIImageView(frame: weatherImageFrame)
        weatherImage!.image = UIImage(named: WeatherIcons.cloudy.name())
        
        let highLowTempLabelFrame = CGRect(x: 0, y: frame.size.height - 20 , width: frame.size.width, height: 16)
        highLowTempLabel = UILabel(frame: highLowTempLabelFrame)
        highLowTempLabel?.font = UIFont(name: "PingFangTC-Light", size: 14)
        highLowTempLabel?.textColor = UIColor.white
        highLowTempLabel?.textAlignment = .center
        highLowTempLabel?.text = "#°/#°"
        
        contentView.addSubview(weatherLabel!)
        contentView.addSubview(timeLabel!)
        contentView.addSubview(tempLabel!)
        contentView.addSubview(weatherImage!)
        contentView.addSubview(highLowTempLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
