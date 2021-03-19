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
    var players: [String] = []

}

extension Team {
    
    func toViewDataTeam() -> TeamViewData {
        return TeamViewData(name: self.name, imageName: self.imageName, type: typeTeam(string: self.type))
    }

}
