//
//  StyleManager.swift
//  WeatherModels
//
//  Created by Kevin Remigio on 6/17/17.
//  Copyright © 2017 Kevin Remigio. All rights reserved.
//

import Foundation

class StyleManager {

    let sharedInstance = StyleManager()
    
    init() { }
    
    func decide(user: User, weather: Weather) -> Outfit? {
        
        var todaysOutfit: Outfit  = Outfit()
        
        switch user.sex! {
        case Gender.Male:
            print("Male fork")
            todaysOutfit = chooseDudeClothes(weather: weather)
        case Gender.Female:
            print("Female fork")
            todaysOutfit = chooseLadyClothes(weather: weather)
        case Gender.WhoCares:
            print("Who cares fork")
            todaysOutfit = chooseClothes(weather: weather)
        }
        
        
        return todaysOutfit
    }
    
    func chooseDudeClothes(weather: Weather) -> Outfit {
        var dudeFit: Outfit!
        
        if let temp = Double(weather.temperature.fahrenheit) {
            if temp > 70 {
                //configure fits first!!!
//                dudeFit = Outfit(
            }
        }

        
        return dudeFit
    }
    func chooseLadyClothes(weather: Weather) -> Outfit {
        let ladyFit: Outfit = Outfit()
        return ladyFit
    }
    func chooseClothes(weather: Weather) -> Outfit {
        let anyFit: Outfit = Outfit()
        return anyFit
    }
}
