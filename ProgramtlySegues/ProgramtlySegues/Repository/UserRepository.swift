//
//  UserRepository.swift
//  Segues
//
//  Created by Israel Torres Alvarado on 11/03/21.
//

import Foundation

class UserRepository {
    
    let user = "aprendeDev@mail.com"
    let password = "1234567890"
    
    func login(userParam: String, passwordParam: String) -> Bool {
            
        guard !userParam.isEmpty, !passwordParam.isEmpty else {
            return false
        }
        
        if userParam.elementsEqual(self.user) && passwordParam.elementsEqual(self.password) {
            return true
        } else {
            return false
        }
    
    }

}
