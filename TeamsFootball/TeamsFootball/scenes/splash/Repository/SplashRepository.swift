//
//  SplashRepository.swift
//  TeamsFootball
//
//  Created by Israel Torres Alvarado on 18/03/21.
//

import Foundation

protocol SplashRepository {
    func sincronizeTeams(completion: @escaping (Bool) -> ())
}

class SplashRepositoryImp: SplashRepository {
    
    let networkManager: NetworkManager
    let storageManager: StorageManager
    
    init(networkManager: NetworkManager, storageManager: StorageManager) {
        self.networkManager = networkManager
        self.storageManager = storageManager
    }
    
    func sincronizeTeams(completion: @escaping (Bool) -> ()) {
        
        guard storageManager.getTeams().count == 0 else {
            return completion(true)
        }
        
        networkManager.getTeams { [weak self] (teams) in
            
            guard let self = self else { return }
            
            self.storageManager.saveTeams(teams: teams)
            let result = self.storageManager.getTeams().count > 0
            completion(result)
        
        }
        
    }

}
