//
//  ListRepository.swift
//  laliga
//
//  Created by Israel Torres Alvarado on 26/03/21.
//

import Foundation
import CoreNetwork
import Alamofire

class ListRepository {

    func getTeams(completion:@escaping (Result<TeamsResponse, AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        APIClient.performRequest(route: APIRouter.teams, decoder: jsonDecoder) { (response) in
            completion(response)
        }
    }
    
}
