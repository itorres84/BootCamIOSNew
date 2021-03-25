//
//  ListTeamsViewModel.swift
//  TeamsFootball
//
//  Created by Israel Torres Alvarado on 17/03/21.
//

import Foundation

class ListTeamsViewModel {
    
    let listRepository: ListRepository
    
    init(listRepository: ListRepository) {
        self.listRepository = listRepository
    }
    
    func getTeams() -> [TeamViewData] {
        return listRepository.getTeams().map({
            TeamViewData(name: $0.name, imageName: $0.imageName, type: typeTeam(string: $0.type))
        })
    }
 
}
