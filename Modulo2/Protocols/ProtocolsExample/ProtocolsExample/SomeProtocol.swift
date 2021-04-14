//
//  SomeProtocol.swift
//  ProtocolsExample
//
//  Created by Israel Torres Alvarado on 08/04/21.
//

import Foundation

protocol SomeProtocol {
    
    //Definicion de protocolo
    
    //Propiedades
    var size: Int { get set }
    var name: String { get }

    //funciones simples
    func greatings()
    //funciones con parametros
    func greatings(name: String)
    //funciones con parametros que retornan un valor
    func greatings(name: String) -> String
    
    //inicializadores
    init(sizeDos: Int)

}

protocol FirstProtocol {
    
}

protocol AnotherProtocol {
    
}

protocol SecondProtocol {
    
    var size: Int { get set }
    
    init(sizeDos: Int)
}


//Who adopt protocol
//1. Structs
struct SomeStruct: FirstProtocol, AnotherProtocol, SomeProtocol {
    
    init(sizeDos: Int) {
        self.size = sizeDos
    }
    
    init(name: String) {
        self.name = "Hola \(name)"
    }
    
    var size: Int = 0
    var name: String = ""
    
    func greatings() {
        
    }
    
    func greatings(name: String) {
        
    }
    
    func greatings(name: String) -> String {
        return ""
    }
    
}

//2. Class
class SomeClass: FirstProtocol, AnotherProtocol, SomeProtocol {
    
    required init(sizeDos: Int) {
        self.size = sizeDos
    }
    
    init(name: String) {
        self.name = name
    }
    
    var size: Int = 0
    var name: String = ""
    
    func greatings() {
        
    }
    
    func greatings(name: String) {
        
    }
    
    func greatings(name: String) -> String {
        return ""
    }
    
    func methodInSomeClass() {
        print("SomeClass.....")
    }
}

//3. Enum

enum SomeEnum: SecondProtocol {
    
    case blue
    case white

    var size: Int {
        get {
            
            switch self {
            case .blue:
                return 1
            default:
                return 0
            }
            
        }
        set {
            self.size = newValue
        }
    }
    
    init(sizeDos: Int) {
        switch sizeDos {
        case 1:
            self = .blue
        default:
            self = .white
        }
    }
    
}

//enum SomeEnum: SomeProtocol {
//    var size: Int
//
//
//    case empty
//    case error
//
//
//    var size: Int {
//        switch self {
//        case .empty, .error:
//            return 0
//        }
//    }
//
//    var name: String {
//        switch self {
//        case .empty:
//            return "Jesus"
//        case .error:
//            return "Maria"
//        }
//    }
//
//    func greatings() {
//
//    }
//
//    func greatings(name: String) {
//
//    }
//
//    func greatings(name: String) -> String {
//        return ""
//    }
//
//    init(sizeDos: Int) {
//        switch sizeDos {
//        case 0:
//            self = .empty
//        case 1:
//            self = .error
//        default:
//            self = .empty
//        }
//    }
//
//}






