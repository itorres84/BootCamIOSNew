//
//  ListRepository.swift
//  TeamsFootball
//
//  Created by Israel Torres Alvarado on 17/03/21.
//

import Foundation

protocol ListRepository {
    func getTeams() -> [Team]
}

class ListRepositoryImp: ListRepository {
    
    let storage: StorageManager
    
    init(storage: StorageManager) {
        self.storage = storage
    }
    
    func getTeams() -> [Team] {
        return storage.getTeams()
    }
    
}
