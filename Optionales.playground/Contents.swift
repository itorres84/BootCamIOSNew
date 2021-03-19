import UIKit

//Optionales
var name: String?
//name = "Valor"

print(name)

if let n = name {
    print("En el if: \(n)")
} else {
    print("else: \(name)")
}

//guard let na = name else {
//    print("el valor es nil")
//}
//
//print("El valor existe y es: \(na)")

class Automovil {
    
    let motor: String
    let ruedas: String
    var T_A: String?
    
    init(motor: String, ruedas: String) {
        self.motor = motor
        self.ruedas = ruedas
    }
    
}

