//
//  TeamViewModel.swift
//  TeamsFootball
//
//  Created by Israel Torres Alvarado on 17/03/21.
//

import Foundation

struct TeamViewData {
    
    let name: String
    let imageName: String
    let type: typeTeam
    
}

enum typeTeam {
    
    case large
    case small
    case none
    
    init(string: String) {
    switch string.lowercased() {
      case "large": self = .large
      case "small": self = .small
      default:
        self = .none
      }
    }
    
}
