//
//  Team.swift
//  laliga
//
//  Created by Israel Torres Alvarado on 26/03/21.
//

import Foundation
import UIKit

struct TeamsResponse: Codable {
    let teams: [Team]
}

struct Team: Codable {
    let name: String
    let imageName: String
    let type: String
}

extension Team {
    
    func toViewData() -> TeamViewData {
        return TeamViewData(name: self.name, image: UIImage(named: self.imageName) ?? UIImage())
    }
    
}
