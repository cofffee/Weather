//
//  ClothesModel.swift
//  WeatherModels
//
//  Created by Kevin Remigio on 6/17/17.
//  Copyright © 2017 Kevin Remigio. All rights reserved.
//

import Foundation
import UIKit

class Outfit {

    var sex: Gender!
    var top: Top!
    var bottom: Trouser!
    var shoes: Shoes!
    
    init() { }
    init(sex: Gender, top: Top, bottom: Trouser, shoes: Shoes) {
        self.sex = sex
        self.top = top
        self.bottom = bottom
        self.shoes = shoes
    }

}


enum Occassion {
    case Casual
    case Formal
    case Work
    case Weekend
    case Party
}
enum MenTops {
    case ShirtShortSleeve
    case ShirtLongSleeve
    case Polo
    case ButtonUpLongSleeve
    case ButtonUpShortSleeve
}
enum MenTrousers {
    case Jeans
    case Chinos
    case Khakis
    case Joggers
    case Shorts
    case WindBreakers
}
class Top {

    init() {
    
    }
}

class Trouser {
    
    init(){
    
    }
}
class Shoes {
    var name: String!
    var sex: Gender!
    var color: UIColor
    init(name: String, sex: Gender, color: UIColor) {
        self.name = name
        self.sex = sex
        self.color = color
    }
}

class Accessory {

    var name: String!
    
}





