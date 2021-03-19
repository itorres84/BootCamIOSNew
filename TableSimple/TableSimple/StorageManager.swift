//
//  StorageManager.swift
//  TableSimple
//
//  Created by Israel Torres Alvarado on 16/03/21.
//

import Foundation

protocol StorageManager {
    func saveNameUser(name: String)
    func getUserSession() -> String?
}

enum keyUserDefault: String {
    case name
    case email
    case password
    case adress
    case sexo
    case showOnboarding
}

class StorageManagerImp: StorageManager {
    
    let userDefault = UserDefaults.standard
    
    func saveNameUser(name: String) {
        userDefault.setValue(name, forKey: keyUserDefault.name.rawValue)
    }
    
    func getUserSession() -> String? {
       return userDefault.string(forKey: keyUserDefault.name.rawValue)
    }

}

