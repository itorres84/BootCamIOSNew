//
//  APIClient.swift
//  Networking
//
//  Created by Israel Torres Alvarado on 25/03/21.
//

import Alamofire

class APIClient {
    
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) {
        
        AF.request(route).responseDecodable(of: T.self) { (response) in
            completion(response.result)
        }
    
    }
        
    static func getInfoCovid(_ country: String, completion:@escaping (Result<CovidResponse, AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        performRequest(route: APIRouter.covidInfo(country), decoder: jsonDecoder, completion: completion)
    }
    
    static func getTeams(completion:@escaping (Result<TeamsResponse, AFError>)->Void) {
       
        let jsonDecoder = JSONDecoder()
        performRequest(route: APIRouter.teams, decoder: jsonDecoder, completion: completion)
    
//        AF.request(APIRouter.teams).response { (response) in
//
//            dump(response.data)
//            dump(response)
//
//
//        }

//        AF.request(APIRouter.teams).responseDecodable(of: TeamsResponse.self) { (response) in
//            
//            dump(response)
//            //completion(response)
//            
//        }
    
    }
}

