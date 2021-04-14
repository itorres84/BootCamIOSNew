//
//  ViewController.swift
//  ProtocolsExample
//
//  Created by Israel Torres Alvarado on 08/04/21.
//

import UIKit

//Protocols optionals
protocol OptionalProtocol {
    var requered: String { get }
    var optional: String? { get }
}
extension OptionalProtocol {
    var optional: String? { return nil }
}

class ViewControllerDos: UIViewController, OptionalProtocol {
    var requered: String = ""
    var optional: String? = "Where ever..."
}

class ViewController: UIViewController, OptionalProtocol {
    
    var requered: String = ""


    func whishHappyBirthday(celebrator: Named & Aged) {
        print("Happy birthday \(celebrator.name) you are \(celebrator.age) years")
    }
    
    func validObjects(objects: [AnyObject]) {
            
        for object in objects {

            if let objectWithArea = object as? HasArea {
                print("Area is \(objectWithArea.area)")
            } else {
                print("Somethig that doesn´t have an area")
                
            }
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Composición imp
        let person = Person(name: "Luis", age: 25)
        whishHappyBirthday(celebrator: person)
        
        //Comprobacion
        
        let objects: [AnyObject] = [Circle(radius: 2.0), Country(area: 243610), Animal(legs: 4)]
        
        validObjects(objects: objects)
        
//
        //let someStruct = SomeStruct(sizeDos: 0)
//        var someStructDos = SomeStruct(name: "Juan")
//        var arraySome: [SomeProtocol] = [someStruct, someStructDos, getSomeProtocol()]
//
//        self.getSome(someProtocol: someStruct)
//        let some = getSomeProtocol()
//        dump(some.greatings())
        
    }
    
//    let name: String
    
//    //parametro de init
//    init(someProtocol: SomeProtocol) {
//        name = someProtocol.greatings(name: "pedro")
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
    //parametro de funcion
    func getSome(someProtocol: SomeProtocol) {
        print(someProtocol.name)
    }
    
    //retorno de funcion
    func getSomeProtocol() -> SomeProtocol {
        let someClass = SomeClass(sizeDos: 0)
        someClass.methodInSomeClass()
        return someClass
    }
    
    func hello(){
        print("Hello")
    }

    func hello(name: String) {
        print("Hello name...")
    }
    
    let closure = { (value: Int) -> Int in
        let result = value + 1
        return result
    }
    
    let closureDos = { (value: Int) -> Void in
        let result = value + 1
        print("El resultado es: \(result)")
    }

}

