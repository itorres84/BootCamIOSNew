//
//  HerenciaProtocol.swift
//  ProtocolsExample
//
//  Created by Israel Torres Alvarado on 08/04/21.
//


//Ver mañana Composición, Comprobación, Implementaciones por defecto

//Composicion  <SomeProtocol, AnotherProtocol>

protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct Person: Named, Aged {
    
    var name: String
    var age: Int
    
}

class ImplementPerson {
        
    func whishHappyBirthday(celebrator: Named & Aged) {
        print("Happy birthday \(celebrator.name) you are \(celebrator.age) years")
    }

}


import Foundation

//compatibles con herencia
protocol InheredingProtocol: SomeProtocol {
    var herenciaName: String { get }
}

//Solo las clases lo pueden implentar
//Protocolos class-only
protocol onlyClassProtocol: class {
    var nameInOnlyClas: String { get }
}

class HerenciaClass: onlyClassProtocol {
    var nameInOnlyClas: String { return "" }
}

struct HerenciaStruct: InheredingProtocol {
 
    var herenciaName: String = ""
    var name: String = ""
    var size: Int = 0
    
    func greatings() {
    }
    
    func greatings(name: String) {
    }
    
    func greatings(name: String) -> String {
        return ""
    }
    
    init(sizeDos: Int) {
        
    }

}
