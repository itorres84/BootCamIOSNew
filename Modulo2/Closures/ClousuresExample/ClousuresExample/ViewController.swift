//
//  ViewController.swift
//  ClousuresExample
//
//  Created by Israel Torres Alvarado on 09/04/21.
//

import UIKit

class ViewController: UIViewController {

    var arithmeticOperation: ((Double, Double) -> Double)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        arithmeticOperation = {
            (lNumber: Double, rNumber: Double) -> Double in
            return lNumber + rNumber
        }
        
        print("5 + 5.2 = \(arithmeticOperation!(5.0,5.2))")
        definedClousure()
        
    }
    
    func definedClousure() {
    
        arithmeticOperation = {
            (lNumber: Double, rNumber: Double) -> Double in
            return lNumber * rNumber
        }
        
        print("5 * 5 = \(arithmeticOperation!(5.0, 5.0))")
        
    }

}

