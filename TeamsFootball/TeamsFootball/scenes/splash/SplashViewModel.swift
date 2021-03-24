//
//  SplashViewModel.swift
//  TeamsFootball
//
//  Created by Israel Torres Alvarado on 18/03/21.
//

import Foundation

final class SplashViewModel {
    
    let repository: SplashRepository
    
    init(repository: SplashRepository) {
        self.repository = repository
    }
    
    func syncTeams(completion: @escaping (Bool) -> ()) {
        repository.sincronizeTeams { (result) in
            completion(result)
        }
    }
    
}
