//
//  File.swift
//  TeamsFootball
//
//  Created by Israel Torres Alvarado on 17/03/21.
//

import Foundation

protocol StorageManager {
    func getTeams() -> [Team]
    func saveTeams(teams: [Team])
}

enum keyUserDefault: String {
    case teams
}

class StorageManagerMock: StorageManager {
    
    func saveTeams(teams: [Team]) {
        
    }
    
    func getTeams() -> [Team] {
        return [Team(name: "Atletico de Madrid", imageName: "Atletico de Madrid", type: "small")]
    }
}

class StorageManagerImp: StorageManager {
    
    let userDefault = UserDefaults.standard
    
    func getTeams() -> [Team] {
        
        if let teamsData = userDefault.object(forKey: keyUserDefault.teams.rawValue) as? Data {
           
            let decoder = PropertyListDecoder()
            let result = try! decoder.decode([Team].self, from: teamsData)
            
            return result
            
        } else {
            return []
        }
    }

    func saveTeams(teams: [Team]) {
        let encoder = PropertyListEncoder()
        let encodeTeam = try! encoder.encode(teams)
        userDefault.setValue(encodeTeam, forKey: keyUserDefault.teams.rawValue)
    }
    
}
