//
//  UserModel.swift
//  WeatherModels
//
//  Created by Kevin Remigio on 6/17/17.
//  Copyright © 2017 Kevin Remigio. All rights reserved.
//

import Foundation

class User {
    var name: String!
    var sex: Gender!
    var age: String!
    var bodyType: BodyType!
    
    init(name: String, sex: Gender, age: String, bodyType: BodyType) {
        self.name = name
        self.sex = sex
        self.age = age
        self.bodyType = bodyType
    }
    
}

enum Gender {
    case Male
    case Female
    case WhoCares
}

enum BodyType {
    case Small
    case Medium
    case Large
}
