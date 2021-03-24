//
//  Team.swift
//  TeamsFootball
//
//  Created by Israel Torres Alvarado on 17/03/21.
//

import Foundation

struct Team: Codable {
    
    let name: String
    let imageName: String
    let type: String
    
    init(name: String, imageName: String, type: String) {
        self.name = name
        self.imageName = imageName
        self.type = type
    }
    
    init(team: [String: Any]) {
        
        if let imageName = team["imageName"] as? String {
            self.imageName = imageName
        } else {
            self.imageName = ""
        }
        
        if let name = team["name"] as? String {
            self.name = name
        } else {
            self.name = ""
        }
        
        if let type = team["type"] as? String {
            self.type = type
        } else {
            self.type = ""
        }
    }
    
}

extension Team {
    
    func toViewDataTeam() -> TeamViewData {
        return TeamViewData(name: self.name, imageName: self.imageName, type: typeTeam(string: self.type))
    }

}
