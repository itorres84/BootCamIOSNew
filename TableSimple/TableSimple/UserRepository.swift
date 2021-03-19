//
//  UserRepository.swift
//  TableSimple
//
//  Created by Israel Torres Alvarado on 16/03/21.
//

import Foundation

class UserRepository {
    
    let storageEmail = "apprenDev@mail.com"
    let storagePassword = "1234567890"
    let returnName = "Israel Torres"
    
    let storgeManager: StorageManager 
    
    init(storgeManager: StorageManager) {
        self.storgeManager = storgeManager
    }

    func login(email: String, password: String) -> Bool {
    
        if email.elementsEqual(storageEmail) && password.elementsEqual(storagePassword) {
            
            storgeManager.saveNameUser(name: returnName)
            
            return true
        } else {
            return false
        }
    }
    
    func getNameUser() -> String? {
        storgeManager.getUserSession()
    }
    
}
