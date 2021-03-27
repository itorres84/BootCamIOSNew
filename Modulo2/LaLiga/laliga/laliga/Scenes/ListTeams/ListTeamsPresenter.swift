//
//  ListTeamsPresenter.swift
//  laliga
//
//  Created by Israel Torres Alvarado on 26/03/21.
//

import Foundation

enum stateTeamsPresenter {
    case loadig
    case setData(_ models: [TeamViewData])
}

protocol ListTeamsPresenterOutput {
    func setState(state: stateTeamsPresenter)
}

class ListTeamsPresenter {
    
    var stateDelegate: ListTeamsPresenterOutput?
    
    private let repository: ListRepository
    
    init(_ repository: ListRepository = ListRepository()) {
        self.repository = repository
        getTeams()
    }
    
    private func getTeams() {
        
        stateDelegate?.setState(state: .loadig)
    
        repository.getTeams { (response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let teamResponse):
                let teamsres = teamResponse.teams.map({ $0.toViewData() })
                self.stateDelegate?.setState(state: .setData(teamsres))
            }
            
        }
    }
    
}
