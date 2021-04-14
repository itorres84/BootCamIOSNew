//
//  HasArea.swift
//  ProtocolsExample
//
//  Created by Israel Torres Alvarado on 09/04/21.
//

import Foundation

protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    
    let pi = 3.1416
    let radius: Double
    
    var area: Double {
        return pi * radius * radius
    }
    
    init(radius: Double) {
        self.radius = radius
    }
    
}

class Country: HasArea {
    
    var area: Double
    
    init(area: Double) {
        self.area = area
    }
}

class Animal {
    
    var legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
    
}
