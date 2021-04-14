import UIKit

/*
 Closures
 Created by Israel Torres
*/

//¿ Que es un clousere ?
//Funcion anonima(sin nombre) en la cual implementamos una funcionalidad especifica como un bloque de codigo que podemos pasar como parametro de funcion o como valor de retorno

//SINTAXIS
// {  (parametros de entrada) -> tipo_de_retorno "in"  declaracion  }
/*
 { (parametros de entrada) -> tipo_de_retorno in
    declaraciones
 }
*/

//Definicion burda de clousere: Bloque de codigo reutilizable

//1. Forma basica
let name: String = "Israel"

let closure = { (value: Int) -> Int in
    let result = value + 1
    return result
}

print(closure(20))
print(type(of: name))
print(type(of: closure))

//1.2 clousure basico sin valor de retorno
print("1.2 clousure basico sin valor de retorno")
let closureDos = { (value: Int) -> Void in
    let result = value + 1
    print("El resultado es: \(result)")
}
closureDos(20)
print(type(of: closureDos))

//1.3 clousure basico sin parametros y sin valor de retorno
print("1.3 clousure basico sin parametros y sin valor de retorno")
let hello = { () -> Void in
    print("Hello....")
}
hello()
print(type(of: hello))

//1.4 clousure basico valor implicito
print("1.4 clousure basico valor implicito")
let clousereTres: (Int) -> Int = {
    
    (value: Int) -> Int in
    let result = value + 1
    return result

}
print(clousereTres(50))
print(type(of: clousereTres))

//1.5 declaracion de closure y despues definicion
print("1.5 declaracion de closure y despues definicion")

var closure4: (Int) -> Int

closure4 = {
    (value: Int) -> Int in
    return value + 1
}

print(closure4(15))

//2. Parametros y Valores de Retorno
print("2. Parametros y Valores de Retorno")

//2.1 Parametros
func runClousure(_ closure: () -> Void) {
    closure()
}
//firma { () -> Void in }
let greetingMessange = {
    () -> Void in
    print("Hi, Nice to meet you! ")
}
runClousure(greetingMessange)

//2.2 retorno de funcion
func returnClosure() -> () -> Void {
    
    return { () -> Void in print("Hi, How it´s going! ") }

}

let closureReturn = returnClosure()
closureReturn()

//3. Capturando valores
print("Capturando valores")

func travel() -> (String) -> Void {
    
    var counter = 0
    
    return {
            
        (destination: String) -> Void in
        counter += 1
        //operador ternario
        let description = counter > 1 ? "veces" : "vez"
        print("Has viajado \(counter)  \(description) a \(destination)")
        
    }
    
}

//4. los closures son tipos por referencia por que apuntan al mismo espacio de memoria y esto le da la capacidad de capturar valores que dependen de su entorno.

let cancunTravel = travel()
cancunTravel("cancun")
cancunTravel("cancun")
cancunTravel("cancun")

print("makeIncrement_______________________________________")

func makeIncrement(forIncrement amount: Int) -> () -> Int {
        
    var runningTotal = 0
    
    func incrmenter() -> Int {
        runningTotal += amount
        return runningTotal
        
    }

    return incrmenter

}

let incrementByTen = makeIncrement(forIncrement: 10)

print(incrementByTen())
print(incrementByTen())
print(incrementByTen())


let alsoIncrementByTen = makeIncrement(forIncrement: 10)

print(alsoIncrementByTen())
print(alsoIncrementByTen())
print(alsoIncrementByTen())

//5. El atributo @escaping
print("5. El atributo @escaping")
/*
 1.-Pasamos el closure como parámetro de una función.
 2.-La función ejecuta el closure.
 4.-La función finaliza su ejecución.
*/


func someFunction(otherNumber: Int, clousure: @escaping (Int) -> Void) {
    let number = 20
    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
        clousure(number + otherNumber)
    }
}


someFunction(otherNumber: 10) { (number) in
    print("El valor de la variable number es \(number)")
}

print("!Punto de referencia!")

//6. Formas que puede adoptar de un Closure
print("6. Formas que puede adoptar de un Closure")

//Forma basica
func calculate(expression: () -> Int) -> Int {
    return expression()
}

//Forma basica reducida
let result = calculate(expression: {
    () -> Int in
    5 + 5
})

print("La suma de 5 + 5 es igual a \(result)")

//Forma reducida
let resultDos = calculate { () -> Int in
    5 + 5
}
print("La suma dos de 5 + 5 es igual a \(resultDos)")


//Forma reducida a dos lineas
let fivePlusFive = { 5 + 5 }
print("La suma tres de 5 + 5 es igual a \(fivePlusFive())")

//Forma reducida a una linea
print("La suma cuatro de 5 + 5 es igual a \({ 5 + 5 }())")

//7. ¿Cuándo usar un closure?
//7.1 El método sort
var volunteerCounts = [1, 3, 40, 32, 2, 53, 77, 13]


//Sort large
//volunteerCounts.sort { (firsElement, secondElement) -> Bool in
//    return firsElement > secondElement
//}

//Sort short
//volunteerCounts.sort(by: { $0 > $1 })

//Extra size short
volunteerCounts.sort(by: > )

print("Sort voluntarios \(volunteerCounts)")

//7.2 El método map

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]

let arrayOfNumbers = [10, 20, 30, 40, 50]
print("Arreglo inicial: \(arrayOfNumbers)")

let convertToTheStringEquivalent = arrayOfNumbers.map { (number) -> String in
    
//    var output = ""
//
//    var tempNumber = number
//
//    while tempNumber > 0 {
//
//        output = digitNames[tempNumber % 10]! + output
//        tempNumber /= 10
//
//    }
    
    return  "\(number)"
    
}

print("Arreglo final: \(convertToTheStringEquivalent)")

//7.3 Bloques de Finalización

//7.4 Creación de Instancias

let nameLabel: UILabel = {
    
    let label = UILabel()
    label.text = "Name:"
    label.textAlignment = .left
    label.numberOfLines = 1
    label.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: UIFont.Weight.regular)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
    
}() // nameLabel





